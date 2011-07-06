class RemoveDateFromSales < ActiveRecord::Migration
  def self.up
    remove_column :sales, :date
  end

  def self.down
  end
end
