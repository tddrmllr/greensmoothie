class Post < ActiveRecord::Base
  include HasImage
  unless (ARGV & ['assets:precompile', 'assets:clean']).any?
    acts_as_taggable
  end

  has_many :comments, as: :commentable
  has_one :image, as: :imageable

  validates_length_of :abstract, :minimum => 50, :maximum => 300, :allow_blank => true

  def named_url
    self.name.downcase.gsub(/[^0-9a-z ]/i, '').gsub(" ", "-")
  end
end
