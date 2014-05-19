class RemoveSourceIdFromNutrients < ActiveRecord::Migration
  def change
    remove_column :nutrients, :source_id
  end
end
