class ExerciseSession < ActiveRecord::Base

  validates :room, :length => {:within => 3..10}

end
