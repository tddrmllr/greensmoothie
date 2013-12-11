class Nutrient < ActiveRecord::Base
  has_many :citations, as: :citable, dependent: :destroy
  has_many :ingredients, through: :citations, source: :citer, source_type: "Ingredient"
  has_many :citations, as: :citer, dependent: :destroy
  has_many :benefits, through: :citations, source: :citable, source_type: "Benefit", dependent: :destroy

  accepts_nested_attributes_for :benefits, allow_destroy: true

end
