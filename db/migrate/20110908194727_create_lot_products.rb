class CreateLotProducts < ActiveRecord::Migration
  def self.up
    create_table :lot_products do |t|
      t.references :lot
      t.references :product
      t.integer :quantity
      t.decimal :cost
      t.integer :cost_cop
      t.integer :sales_cost
      t.integer :utility
      t.integer :price

      t.timestamps
    end
  end

  def self.down
    drop_table :lot_products
  end
end
