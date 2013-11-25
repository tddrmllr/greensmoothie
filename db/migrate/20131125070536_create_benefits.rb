class CreateBenefits < ActiveRecord::Migration
  def change
    create_table :benefits do |t|
      t.string :name
      t.text :description
      t.text :source
      t.integer :flags
      t.integer :benefactor_id
      t.string :benefactor_type

      t.timestamps
    end
  end
end
