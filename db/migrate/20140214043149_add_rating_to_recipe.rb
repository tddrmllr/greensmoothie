class AddRatingToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :rating, :decimal, precision: 1
  end
end
