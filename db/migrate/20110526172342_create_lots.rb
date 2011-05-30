class CreateLots < ActiveRecord::Migration
  def self.up
    create_table :lots do |t|
      t.date :arrival_date
      t.integer :freight
      t.string :carrier
      t.string :origin
      t.integer :weight
      t.integer :total_cost

      t.timestamps
    end
  end

  def self.down
    drop_table :lots
  end
end
