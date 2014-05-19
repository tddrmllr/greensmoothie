class AddSourceToNutrient < ActiveRecord::Migration
  def change
    add_column :nutrients, :source_id, :integer
  end
end
