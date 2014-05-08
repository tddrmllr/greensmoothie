class User < ActiveRecord::Base

  include HasImage
  require 'mailchimp'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :recipes
  has_many :authentications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy

  validates :username, uniqueness: true, format: {with: /\A[A-Za-z\d_]+\Z/}, case_sensitive: false, allow_blank: true
  validate :username_cannot_be_blank, :agree_to_terms_of_service

  before_save :update_mailchimp_subscription

  def admin?
    self.role == "Admin"
  end

  def agree_to_terms_of_service
    if self.sign_in_count > 0 && self.terms_of_service.blank?
      errors.add(:base, "Please indicate that you agree to our terms of service")
    end
  end

  def apply_omniauth(auth)
    self.email = auth.info.email if self.email.blank?
    self.name = auth.info.name if self.name.blank?
    authentications.build(provider: auth.provider, uid: auth.id)
  end

  def email_required?
    super && self.sign_in_count > 0
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

  def subscribe_mailchimp
    mailchimp = Mailchimp::API.new("fc59b4a51e93628dcc7152f899c97358-us8")
    begin
      member = mailchimp.lists.subscribe "6a584771e4", {email: self.email}, {}, {}, double_optin: false
    rescue Mailchimp::ListAlreadySubscribedError
      puts "already subscribed"
    rescue Mailchimp::Error => ex
      puts "some error"
    end
    self.update_column :mailchimp_member_id, member['euid']
  end

  def unsubscribe_mailchimp
    mailchimp = Mailchimp::API.new("fc59b4a51e93628dcc7152f899c97358-us8")
    begin
      mailchimp.lists.unsubscribe "6a584771e4", {email: self.email}
    rescue Mailchimp::EmailNotExistsError
      puts "not subscribed"
    end
    self.update_column :mailchimp_member_id, nil
  end

  def update_mailchimp_subscription
    unless self.email.blank?
      if self.mailchimp_member_id.nil? && self.email_list == true
        subscribe_mailchimp
      elsif !self.mailchimp_member_id.nil? && !self.changes[:email].blank? && self.email_list == true
        update_mailchimp
      elsif self.email_list == false
        unsubscribe_mailchimp
      end
    end
  end

  def update_mailchimp
    mailchimp = Mailchimp::API.new("fc59b4a51e93628dcc7152f899c97358-us8")
    begin
      mailchimp.lists.update_member "6a584771e4", {email: self.changes["email"][0]}, {"new-email" => self.changes["email"][1]}
    rescue Mailchimp::ListAlreadySubscribedError
      puts "already subscribed"
    rescue Mailchimp::Error => ex
      puts "some error"
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
