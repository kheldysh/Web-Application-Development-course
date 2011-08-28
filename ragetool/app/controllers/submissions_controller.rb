class SubmissionsController < ApplicationController

  def create
    submission = current_user.submissions.new(params[:submission])
    submission.exercise_id = params[:exercise_id]
    submission.save!
    
    redirect_to exercises_path
  end
end
