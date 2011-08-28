class CreateSubmissions < ActiveRecord::Migration
  def self.up
    create_table :submissions do |t|
      t.references :user
      t.references :exercise
      t.text :answer

      t.timestamps
    end
  end

  def self.down
    drop_table :submissions
  end
end
