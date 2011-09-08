class AddVoidedToSales < ActiveRecord::Migration
  def self.up
    add_column :sales, :voided, :boolean, :default=>false
  end

  def self.down
    remove_column :sales, :voided
  end
end
