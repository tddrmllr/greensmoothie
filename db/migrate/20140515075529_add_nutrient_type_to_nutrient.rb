class AddNutrientTypeToNutrient < ActiveRecord::Migration
  def change
    add_column :nutrients, :nutrient_type, :string
  end
end
