class CreateMisales < ActiveRecord::Migration
  def self.up
    create_table :misales do |t|
      t.string :head
      t.string :tail
      t.string :illustration
      t.string :tag
      t.integer :ye
      t.integer :ne

      t.timestamps
    end
  end

  def self.down
    drop_table :misales
  end
end
