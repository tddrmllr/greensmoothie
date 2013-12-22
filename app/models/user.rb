class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :recipes
  has_many :authentications

  def admin?
    self.role == "Admin"
  end

  def apply_omniauth(auth)
    self.email = auth.info.email if email.blank?
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
