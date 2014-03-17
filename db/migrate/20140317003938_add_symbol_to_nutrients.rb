class AddSymbolToNutrients < ActiveRecord::Migration
  def change
    add_column :nutrients, :symbol, :string
  end
end
