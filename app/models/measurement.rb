class Measurement < ActiveRecord::Base
  belongs_to :recipes
  belongs_to :ingredients

  accepts_nested_attributes_for :ingredients, allow_destroy: true
end