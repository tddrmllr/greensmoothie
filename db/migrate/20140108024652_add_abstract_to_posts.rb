class AddAbstractToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :abstract, :text
    add_column :posts, :user_id, :integer
  end
end
