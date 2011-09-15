class RenameColorSizeForProducts < ActiveRecord::Migration
  def self.up
    rename_column :sizes,:size,:name
    rename_column :colors,:color,:name
  end

  def self.down
    rename_column :sizes,:name,:size
    rename_column :colors,:name,:color
  end
end
