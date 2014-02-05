class User < ActiveRecord::Base

  include HasImage

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :recipes
  has_many :authentications
  has_many :comments
  has_one :image, as: :imageable

  validates :username, uniqueness: true

  def admin?
    self.role == "Admin"
  end

  def apply_omniauth(auth)
    self.email = auth.info.email if self.email.blank?
    self.name = auth.info.name if self.name.blank?
    authentications.build(provider: auth.provider, uid: auth.id)
  end

  def password_required?
    super && !self.authentications.any?
  end

  def provider?(provider)
    authentications.where(provider: provider.to_s).any?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
