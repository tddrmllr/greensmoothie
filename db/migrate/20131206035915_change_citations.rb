class ChangeCitations < ActiveRecord::Migration
  def change
    remove_column :citations, :citer_id
    remove_column :citations, :citer_type
    remove_column :citations, :citable_type
    rename_column :citations, :citable_id, :nutrient_id
  end
end
