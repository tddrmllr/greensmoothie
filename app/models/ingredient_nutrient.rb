class IngredientNutrient < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :nutrient

  def name
    self.nutrient.name
  end
end
