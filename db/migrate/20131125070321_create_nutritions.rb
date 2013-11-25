class CreateNutritions < ActiveRecord::Migration
  def change
    create_table :nutrients do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
