class AddCostToStocks < ActiveRecord::Migration
  def self.up
    add_column :stocks, :cost, :integer
  end

  def self.down
    remove_column :stocks, :cost
  end
end
