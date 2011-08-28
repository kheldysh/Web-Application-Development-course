class ExercisesController < ApplicationController

  skip_before_filter :authenticate_user!

  def index
    @exercises = Exercise.all
    
    respond_to do |format|
      format.xml { render :xml => @exercises.to_xml }
      format.json { render :json => @exercises.to_json }
      format.html
    end
    
  end
  
  def show
    @exercise = Exercise.find(params[:id])

    respond_to do |format|
      format.xml { render :xml => @exercise.to_xml }
      format.json { render :json => @exercises.to_json }
      format.html
    end
  end
end
