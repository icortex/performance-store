class CreateStocks < ActiveRecord::Migration
  def self.up
    create_table :stocks do |t|
      t.references :product
      t.integer :quantity
      t.integer :price
      t.references :headquarter

      t.timestamps
    end
  end

  def self.down
    drop_table :stocks
  end
end
