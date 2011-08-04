class CreateCarriers < ActiveRecord::Migration
  def self.up
    create_table :carriers do |t|
      t.string :company
      t.string :city
      t.string :contact
      t.string :email
      t.string :phone
      t.string :address
      t.string :website

      t.timestamps
    end
  end

  def self.down
    drop_table :carriers
  end
end
