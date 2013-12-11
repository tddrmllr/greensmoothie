class ChangeCitationBack < ActiveRecord::Migration
  def change
    rename_column :citations, :nutrient_id, :citable_id
    rename_column :citations, :ingredient_id, :citer_id
    add_column :citations, :citable_type, :string
    add_column :citations, :citer_type, :string
  end
end
