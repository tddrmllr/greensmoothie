class AddSizeToIngredient < ActiveRecord::Migration
  def change
    add_column :ingredients, :serving_size, :string
  end
end
