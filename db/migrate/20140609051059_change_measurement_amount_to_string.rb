class ChangeMeasurementAmountToString < ActiveRecord::Migration
  def change
    change_column :measurements, :amount, :string
  end
end
