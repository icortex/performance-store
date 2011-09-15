class AddPriceToLotProducts < ActiveRecord::Migration
  def self.up
    add_column :lot_products, :price, :integer
  end

  def self.down
    remove_column :lot_products, :price
  end
end
