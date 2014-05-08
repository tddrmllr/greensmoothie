class Post < ActiveRecord::Base
  include HasImage
  unless (ARGV & ['assets:precompile', 'assets:clean']).any?
    acts_as_taggable
  end

  has_many :comments, as: :commentable

  default_scope order: 'created_at DESC'
  scope :core, where(core_content: true)

  validates_length_of :abstract, :minimum => 50, :maximum => 400, :allow_blank => true

  def dashed_name
    self.name.downcase.gsub(/[^0-9a-z ]/i, '').gsub(" ", "-")
  end

  def named_route
    title = self.name.downcase.gsub(/[^0-9a-z ]/i, '').gsub(" ", "-")
    return "/posts/#{self.id}/#{title}"
  end
end
