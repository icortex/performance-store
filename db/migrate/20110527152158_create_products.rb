class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.references :brand
      t.references :cloth_type
      t.string :reference
      t.string :model
      t.string :barcode
      t.string :gender
      t.binary :image
      t.references :size
      t.references :color

      t.timestamps

    end
    
  end

  def self.down
    drop_table :products
  end
end
