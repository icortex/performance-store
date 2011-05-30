class CreateClothTypes < ActiveRecord::Migration
  def self.up
    create_table :cloth_types do |t|
      t.string :cloth_type

      t.timestamps
    end
  end

  def self.down
    drop_table :cloth_types
  end
end
