class CreateSignups < ActiveRecord::Migration
  def self.up
    create_table :signups do |t|
      t.references :user
      t.references :exercise_session

      t.timestamps
    end
  end

  def self.down
    drop_table :signups
  end
end
