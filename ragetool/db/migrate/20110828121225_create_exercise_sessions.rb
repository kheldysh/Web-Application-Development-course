class CreateExerciseSessions < ActiveRecord::Migration
  def self.up
    create_table :exercise_sessions do |t|
      t.string :room
      t.timestamp :starts_at

      t.timestamps
    end
  end

  def self.down
    drop_table :exercise_sessions
  end
end
