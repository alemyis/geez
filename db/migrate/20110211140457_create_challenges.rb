class CreateChallenges < ActiveRecord::Migration
  def self.up
    create_table :challenges do |t|
      t.string :title
      t.text :note
      t.integer :status, :default => '0'
      
      t.timestamps
    end
  end

  def self.down
    drop_table :challenges
  end
end
