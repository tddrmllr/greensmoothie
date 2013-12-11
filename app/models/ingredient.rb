class Ingredient < ActiveRecord::Base

  include HasImage

  has_many :measurements, dependent: :destroy
  has_many :recipes, through: :measurements
  has_one :image, as: :imageable
  has_many :citations, as: :citer, dependent: :destroy
  has_many :nutrients, through: :citations, source: :citable, source_type: "Nutrient"

  accepts_nested_attributes_for :citations, allow_destroy: true
  accepts_nested_attributes_for :measurements
end
