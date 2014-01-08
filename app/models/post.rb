class Post < ActiveRecord::Base

  has_many :comments, as: :commentable

  def title_url
    self.title.downcase.gsub(/[^0-9a-z ]/i, '').gsub(" ", "-")
  end
end
