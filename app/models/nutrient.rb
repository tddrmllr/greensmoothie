class Nutrient < ActiveRecord::Base
  has_many :citations, dependent: :destroy
  has_many :ingredients, through: :citations
end
