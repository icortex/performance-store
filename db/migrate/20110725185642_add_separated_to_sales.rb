class AddSeparatedToSales < ActiveRecord::Migration
  def self.up
    add_column :sales, :separated, :boolean, :default => false
  end

  def self.down
    remove_column :sales, :separated
  end
end
