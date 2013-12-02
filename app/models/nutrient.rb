class Nutrient < ActiveRecord::Base
  has_and_belongs_to_many :ingredients
  has_many :benefits, as: :benefactor

  accepts_nested_attributes_for :benefits, allow_destroy: true
end
