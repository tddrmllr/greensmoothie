class Nutrient < ActiveRecord::Base
  has_many :citables, as: :citer, class_name: "Citation", dependent: :destroy
  has_many :ingredients, through: :citers, source: :citer, source_type: "Ingredient"
  has_many :citers, as: :citable, class_name: "Citation", dependent: :destroy
  has_many :benefits, through: :citables, source: :citable, source_type: "Benefit", dependent: :destroy

  accepts_nested_attributes_for :benefits, allow_destroy: true


  validates :name, presence: true
  validates_length_of :symbol, maximum: 3



end
