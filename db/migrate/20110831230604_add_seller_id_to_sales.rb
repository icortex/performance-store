class AddSellerIdToSales < ActiveRecord::Migration
  def self.up
    add_column :sales, :seller_id, :integer
  end

  def self.down
    remove_column :sales, :seller_id
  end
end
