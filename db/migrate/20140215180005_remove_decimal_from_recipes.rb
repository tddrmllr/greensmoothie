class RemoveDecimalFromRecipes < ActiveRecord::Migration
  def change
    remove_column :ratings, :decimal
  end
end
