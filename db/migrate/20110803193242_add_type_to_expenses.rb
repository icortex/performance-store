class AddTypeToExpenses < ActiveRecord::Migration
  def self.up
    add_column :expenses, :expense_type_id, :integer
  end

  def self.down
    remove_column :expenses, :expense_type_id
  end
end
