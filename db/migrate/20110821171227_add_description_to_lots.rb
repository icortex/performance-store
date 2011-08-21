class AddDescriptionToLots < ActiveRecord::Migration
  def self.up
    add_column :lots, :description, :string
  end

  def self.down
    remove_column :lots, :description
  end
end
