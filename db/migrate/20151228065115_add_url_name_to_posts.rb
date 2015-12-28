class AddUrlNameToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :url_name, :string
  end
end
