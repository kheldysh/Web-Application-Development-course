class ExercisesController < ApplicationController

  def index
    @exercises = Exercise.all
    
    respond_to do |format|
      format.xml { render :xml => @exercises.to_xml }
      format.html
    end
    
  end
  
  def show
    @exercise = Exercise.find(params[:id])

    respond_to do |format|
      format.xml { render :xml => @exercise.to_xml }
      format.html
    end
  end
end
