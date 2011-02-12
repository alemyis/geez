class CreateCategorizations < ActiveRecord::Migration
  def self.up
    create_table :categorizations do |t|
      t.integer :misale_id
      t.integer :challenge_id
      t.integer :position
      t.datetime :created_at

      t.timestamps
    end
  end

  def self.down
    drop_table :categorizations
  end
end
