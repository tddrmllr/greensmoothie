class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string   :image_file_name
      t.string   :image_content_type
      t.integer  :image_file_size
      t.datetime :image_updated_at
      t.string :imageable_type
      t.integer :imageable_id
    end
  end
end
