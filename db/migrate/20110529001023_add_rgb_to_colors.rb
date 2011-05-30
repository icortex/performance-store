class AddRgbToColors < ActiveRecord::Migration
  def self.up
    add_column :colors, :rgb, :string
  end

  def self.down
    remove_column :colors, :rgb
  end
end
