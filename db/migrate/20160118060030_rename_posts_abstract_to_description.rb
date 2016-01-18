class RenamePostsAbstractToDescription < ActiveRecord::Migration
  def change
    rename_column :posts, :abstract, :description
  end
end
