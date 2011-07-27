class AddValidatedToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :validated, :boolean, :default => false
  end

  def self.down
    remove_column :users, :validated
  end
end
