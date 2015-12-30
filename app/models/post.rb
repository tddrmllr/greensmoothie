class Post < ActiveRecord::Base
  include HasImage

  belongs_to :user

  default_scope -> { order('created_at DESC') }
  scope :core,-> { where(core_content: true) }

  validates :abstract, presence: true
  validates :body, presence: true
  validates :name, presence: true
  validates_uniqueness_of :name
  validates_length_of :abstract, :minimum => 50, :maximum => 400, :allow_blank => true

  before_save :set_url_name

  def dashed_name
    self.name.downcase.gsub(/[^0-9a-z ]/i, '').gsub(" ", "-")
  end

  def named_route
    "/blog/#{url_name}"
  end

  private

  def set_url_name
    self.url_name = (name || '').downcase.gsub(/[^0-9a-z ]/i, '').gsub(" ", "-")
  end
end
