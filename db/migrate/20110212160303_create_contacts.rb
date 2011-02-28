class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :nickname
      t.string :email
      t.string :phone
      t.string :fbuid

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
