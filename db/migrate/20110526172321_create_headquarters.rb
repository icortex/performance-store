class CreateHeadquarters < ActiveRecord::Migration
  def self.up
    create_table :headquarters do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :headquarters
  end
end
