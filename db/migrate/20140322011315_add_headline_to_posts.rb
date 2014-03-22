class AddHeadlineToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :headline, :text
  end
end
