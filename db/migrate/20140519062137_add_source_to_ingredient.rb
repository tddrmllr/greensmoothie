class AddSourceToIngredient < ActiveRecord::Migration
  def change
    add_column :ingredients, :source_url, :string
  end
end
