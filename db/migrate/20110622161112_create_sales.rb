class CreateSales < ActiveRecord::Migration
  def self.up
    create_table :sales do |t|
      t.references :person
      t.integer :discount
      t.string :discount_reason
      t.datetime :date
      t.integer :iva
      t.integer :total

      t.timestamps
    end
  end

  def self.down
    drop_table :sales
  end
end
