class AddDvToNutrients < ActiveRecord::Migration
  def change
    add_column :nutrients, :daily_value_amount, :decimal
    add_column :nutrients, :daily_value_unit, :string
  end
end
