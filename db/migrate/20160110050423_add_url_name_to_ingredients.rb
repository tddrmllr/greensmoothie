class AddUrlNameToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :url_name, :string
  end
end
