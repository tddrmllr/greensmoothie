class CreateIngredientNutrients < ActiveRecord::Migration
  def change
    create_table :ingredient_nutrients do |t|
      t.integer :ingredient_id
      t.integer :nutrient_id
      t.string :amount

      t.timestamps
    end
  end
end
