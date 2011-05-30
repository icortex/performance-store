class CreateLotProducts < ActiveRecord::Migration
  def self.up
    create_table :lot_products do |t|
      t.references :product
      t.references :lot
      t.integer :quantity
      t.integer :unit_cost

      t.timestamps
    end
  end

  def self.down
    drop_table :lot_products
  end
end
