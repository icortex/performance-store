class AddHeadquarterToSales < ActiveRecord::Migration
  def self.up
    add_column :sales, :headquarter_id, :integer
  end

  def self.down
    remove_column :sales, :headquarter_id
  end
end
