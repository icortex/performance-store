class AddPinToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :pin, :string
  end

  def self.down
    remove_column :people, :pin
  end
end
