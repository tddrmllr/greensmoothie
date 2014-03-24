class User < ActiveRecord::Base

  include HasImage
  require 'mailchimp'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :recipes
  has_many :authentications
  has_many :comments
  has_one :image, as: :imageable
  has_many :ratings

  validates :username, uniqueness: true, format: {with: /\A[A-Za-z\d_]+\Z/}, case_sensitive: false
  validate :username_cannot_be_blank

  before_save :update_mailchimp

  def admin?
    self.role == "Admin"
  end

  def apply_omniauth(auth)
    self.email = auth.info.email if self.email.blank?
    self.name = auth.info.name if self.name.blank?
    authentications.build(provider: auth.provider, uid: auth.id)
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:username)
    where(conditions).where(["lower(username) = :value", { :value => login.downcase }]).first
  end

  def password_required?
    super && !self.authentications.any?
  end

  def provider?(provider)
    authentications.where(provider: provider.to_s).any?
  end

  def rating?(recipe)
    ratings.where(recipe_id: recipe.id).any?
  end

  def subscribe(mailchimp)
    begin
      mailchimp.lists.subscribe "6a584771e4", {email: self.email}, {}, {}, double_optin: false
    rescue Mailchimp::ListAlreadySubscribedError
      mailchimp.lists.update_member "6a584771e4", {email: self.changes["email"][0]}, {email: self.changes["email"][1]} if self.email_changed?
    rescue Mailchimp::Error => ex
      puts "some error"
    end
  end

  def unsubscribe(mailchimp)
    begin
      mailchimp.lists.unsubscribe("6a584771e4", {email: self.email})
    rescue Mailchimp::EmailNotExistsError
      puts "not subscribed"
    end
  end

  def update_mailchimp
    unless self.email.blank?
      mailchimp = Mailchimp::API.new("fc59b4a51e93628dcc7152f899c97358-us8")
      if self.email_list
        subscribe(mailchimp)
      elsif self.email_list_changed?
        unsubscribe(mailchimp)
      end
    end
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def username_cannot_be_blank
    if self.sign_in_count > 0 && self.username.blank?
      errors.add(:username, "can't be blank")
    end
  end
end
