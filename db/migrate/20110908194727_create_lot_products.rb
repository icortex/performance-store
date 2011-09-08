class CreateLotProducts < ActiveRecord::Migration
  def self.up
    create_table :lot_products do |t|
      t.references :lot
      t.references :product
      t.integer :quantity
      t.integer :cost
      t.integer :utility

      t.timestamps
    end
  end

  def self.down
    drop_table :lot_products
  end
end
