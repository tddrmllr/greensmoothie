class Recipe < ActiveRecord::Base
  include HasImage
  unless (ARGV & ['assets:precompile', 'assets:clean']).any?
    acts_as_taggable
  end

  belongs_to :user
  has_many :measurements
  has_many :ingredients, through: :measurements
  has_one :image, as: :imageable
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :measurements, allow_destroy: true

  validates :name, :description, presence: true

  def named_url
    self.name.downcase.gsub(/[^0-9a-z ]/i, '').gsub(" ", "-")
  end
end
