class ExerciseSession < ActiveRecord::Base

  validates :room, :length => {:within => 3..10}

  has_many :signups # all signups
  has_many :users, :through => :signups # all users through the join table
end
