class AddIngredientsToCitations < ActiveRecord::Migration
  def change
    add_column :citations, :ingredient_id, :integer
  end
end
