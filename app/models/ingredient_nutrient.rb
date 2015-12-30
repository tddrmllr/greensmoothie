class IngredientNutrient < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :nutrient

  scope :macronutrients, -> { joins(:nutrient).where(nutrients: { nutrient_type: Nutrient::MACRONUTRIENT }) }
  scope :minerals, -> { joins(:nutrient).where(nutrients: { nutrient_type: Nutrient::MINERAL }) }
  scope :vitamins, -> { joins(:nutrient).where(nutrients: { nutrient_type: Nutrient::VITAMIN }) }

  delegate :name, to: :nutrient

  def daily_percent
    dv = nutrient.daily_value_amount
    p = amount.to_d / dv unless dv.nil?
    p * 100 unless p.nil?
  end
end
