class Ingredient < ActiveRecord::Base

  include HasImage

  has_many :measurements
  has_many :recipes, through: :measurements
  has_one :image, as: :imageable
  has_many :citations, as: :citer
  has_many :nutrients, through: :citations

  accepts_nested_attributes_for :citations, allow_destroy: true
end
