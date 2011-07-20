class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.string :name
      t.string :description
      t.integer :cost

      t.timestamps
    end
  end

  def self.down
    drop_table :expenses
  end
end
