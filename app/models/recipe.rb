class Recipe < ActiveRecord::Base
  include HasImage
  acts_as_taggable

  belongs_to :user
  has_many :measurements
  has_many :ingredients, through: :measurements
  has_one :image, as: :imageable
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :measurements, allow_destroy: true

  validates :name, :description, presence: true
end
