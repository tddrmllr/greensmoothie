class ChangeUserEmailPrefs < ActiveRecord::Migration
  def change
    change_column :users, :recipes_email, :boolean, default: true
    change_column :users, :general_email, :boolean, default: true
  end
end
