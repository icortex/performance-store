class AddHeadquarterToExpenses < ActiveRecord::Migration
  def self.up
    add_column :expenses, :headquarter_id, :integer
  end

  def self.down
    remove_column :expenses, :headquarter_id
  end
end
