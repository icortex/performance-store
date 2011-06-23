class CreateSaleProducts < ActiveRecord::Migration
  def self.up
    create_table :sale_products do |t|
      t.references :sale
      t.references :product
      t.integer :quantity
      t.integer :price

      t.timestamps
    end
  end

  def self.down
    drop_table :sale_products
  end
end
