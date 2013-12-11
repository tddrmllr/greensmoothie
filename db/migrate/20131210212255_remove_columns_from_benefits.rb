class RemoveColumnsFromBenefits < ActiveRecord::Migration
  def change
    remove_column :benefits, :benefactor_type
    remove_column :benefits, :benefactor_id
    remove_column :benefits, :flags
    remove_column :benefits, :source
  end
end
