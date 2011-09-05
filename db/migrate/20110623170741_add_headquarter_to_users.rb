class AddHeadquarterToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :headquarter_id, :integer, :default => 1
  end

  def self.down
    remove_column :users, :headquarter_id
  end
end
