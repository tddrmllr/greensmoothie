class CreateIngredientsRecipes < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.integer :ingredient_id
      t.integer :recipe_id
      t.decimal :amount
      t.string :unit

      t.timestamps
    end
  end
end
