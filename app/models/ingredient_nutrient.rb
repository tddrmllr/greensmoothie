class IngredientNutrient < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :nutrient

  def daily_percent
    dv = self.nutrient.daily_value_amount
    p = self.amount.to_f / dv unless dv.nil?
    p * 100 unless p.nil?
  end

  def name
    self.nutrient.name
  end
end
