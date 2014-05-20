class AddUsdaNameToIngredient < ActiveRecord::Migration
  def change
    add_column :ingredients, :usda_name, :string
  end
end
