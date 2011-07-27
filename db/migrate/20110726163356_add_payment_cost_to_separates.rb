class AddPaymentCostToSeparates < ActiveRecord::Migration
  def self.up
    add_column :separates, :payment_cost, :integer
  end

  def self.down
    remove_column :separates, :payment_cost
  end
end
