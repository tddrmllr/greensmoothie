class IngredientNutrient < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :nutrient

  delegate :name, to: :nutrient

  def daily_percent
    dv = nutrient.daily_value_amount
    p = amount.to_d / dv unless dv.nil?
    p * 100 unless p.nil?
  end
end
