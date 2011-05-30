class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :name
      t.date :birthday
      t.string :document_id
      t.string :gender
      t.string :phone
      t.string :mobile

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
