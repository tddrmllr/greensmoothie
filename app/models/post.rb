class Post < ActiveRecord::Base
  include HasImage
  acts_as_taggable

  has_many :comments, as: :commentable
  has_one :image, as: :imageable

  def named_url
    self.name.downcase.gsub(/[^0-9a-z ]/i, '').gsub(" ", "-")
  end
end
