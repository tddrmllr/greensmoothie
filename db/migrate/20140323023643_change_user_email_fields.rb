class ChangeUserEmailFields < ActiveRecord::Migration
  def change
    remove_column :users, :recipes_email
    rename_column :users, :general_email, :email_list
    add_column :users, :recipe_updates, :boolean, default: true
  end
end
