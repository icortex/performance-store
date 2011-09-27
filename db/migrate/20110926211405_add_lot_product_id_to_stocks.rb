class AddLotProductIdToStocks < ActiveRecord::Migration
  def self.up
    add_column :stocks, :lot_product_id, :integer
  end

  def self.down
    remove_column :stocks, :lot_product_id
  end
end
