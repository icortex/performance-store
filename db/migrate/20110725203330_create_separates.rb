class CreateSeparates < ActiveRecord::Migration
  def self.up
    create_table :separates do |t|
      t.references :sale
      t.integer :payment

      t.timestamps
    end
  end

  def self.down
    drop_table :separates
  end
end
