class Ingredient < ActiveRecord::Base
  has_many :measurements
  has_many :recipes, through: :measurements
  has_and_belongs_to_many :nutrients
end
