class AddCoreToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :core_content, :boolean, default: false
  end
end
