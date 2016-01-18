class Post < ActiveRecord::Base
  include Disqusable
  include HasImage

  belongs_to :user

  default_scope -> { where.not(published_at: nil).order('created_at DESC') }

  validates :description, presence: true
  validates :body, presence: true
  validates :name, presence: true
  validates_uniqueness_of :name
  validates_length_of :description, minimum: 50, maximum: 400, allow_blank: true

  before_save :set_url_name

  def self.unpublished
    unscoped.where(published_at: nil)
  end

  def named_route
    "/blog/#{url_name}"
  end

  def published?
    published_at.present?
  end

  private

  def set_url_name
    self.url_name = (name || '').downcase.gsub(/[^0-9a-z ]/i, '').gsub(" ", "-")
  end
end
