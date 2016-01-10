class AddUrlNameToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :url_name, :string
  end
end
