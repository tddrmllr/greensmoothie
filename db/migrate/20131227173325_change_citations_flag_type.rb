class ChangeCitationsFlagType < ActiveRecord::Migration
  def change
    change_column :citations, :flags, :integer, default: 0
  end
end
