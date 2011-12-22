class ChangeCostLotProductDataType < ActiveRecord::Migration
  def self.up
    change_column :lot_products, :cost, :float
  end

  def self.down
    change_column :lot_products, :cost, :decimal
  end
end
