class IngredientNutrient < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :nutrient

  scope :macronutrients, -> { joins(:nutrient).merge(Nutrient.macronutrients) }
  scope :minerals, -> { joins(:nutrient).merge(Nutrient.minerals) }
  scope :vitamins, -> { joins(:nutrient).merge(Nutrient.vitamins) }

  delegate :name, to: :nutrient

  def daily_percent
    dv = nutrient.daily_value_amount
    p = amount.to_d / dv unless dv.nil?
    p * 100 unless p.nil?
  end
end
