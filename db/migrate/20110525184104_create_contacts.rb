class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :key
      t.string :value
      t.integer :person_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
