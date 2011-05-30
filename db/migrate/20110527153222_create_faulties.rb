class CreateFaulties < ActiveRecord::Migration
  def self.up
    create_table :faulties do |t|
      t.references :product
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :faulties
  end
end
