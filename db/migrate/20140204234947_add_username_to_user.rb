class AddUsernameToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :recipes_email, :boolean
    add_column :users, :general_email, :boolean
  end
end
