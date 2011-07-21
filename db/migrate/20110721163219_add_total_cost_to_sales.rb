class AddTotalCostToSales < ActiveRecord::Migration
  def self.up
    add_column :sales, :total_cost, :integer
  end

  def self.down
    remove_column :sales, :total_cost
  end
end
