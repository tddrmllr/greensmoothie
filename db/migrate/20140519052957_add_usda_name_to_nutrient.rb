class AddUsdaNameToNutrient < ActiveRecord::Migration
  def change
    add_column :nutrients, :usda_name, :string
  end
end
