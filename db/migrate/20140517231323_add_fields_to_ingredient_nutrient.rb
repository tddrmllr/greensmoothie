class AddFieldsToIngredientNutrient < ActiveRecord::Migration
  def change
    add_column :ingredient_nutrients, :daily_value, :decimal
    add_column :ingredient_nutrients, :unit, :string
  end
end
