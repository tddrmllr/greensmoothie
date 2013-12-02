class CreateCitations < ActiveRecord::Migration
  def change
    create_table :citations do |t|
      t.string :source
      t.integer :flags
      t.string :citable_type
      t.integer :citable_id
      t.string :citer_type
      t.integer :citer_id
    end
  end
end
