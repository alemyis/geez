class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.integer :contact_id
      t.integer :categorization_id
      t.string :response
      t.string :illustration

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
