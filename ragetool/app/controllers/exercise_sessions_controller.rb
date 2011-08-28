class ExerciseSessionsController < ApplicationController
  # GET /exercise_sessions
  # GET /exercise_sessions.xml
  def index
    @exercise_sessions = ExerciseSession.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @exercise_sessions }
    end
  end

  # GET /exercise_sessions/1
  # GET /exercise_sessions/1.xml
  def show
    @exercise_session = ExerciseSession.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @exercise_session }
    end
  end

  # GET /exercise_sessions/new
  # GET /exercise_sessions/new.xml
  def new
    @exercise_session = ExerciseSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @exercise_session }
    end
  end

  # GET /exercise_sessions/1/edit
  def edit
    @exercise_session = ExerciseSession.find(params[:id])
  end

  # POST /exercise_sessions
  # POST /exercise_sessions.xml
  def create
    @exercise_session = ExerciseSession.new(params[:exercise_session])

    respond_to do |format|
      if @exercise_session.save
        format.html { redirect_to(@exercise_session, :notice => 'Exercise session was successfully created.') }
        format.xml  { render :xml => @exercise_session, :status => :created, :location => @exercise_session }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @exercise_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /exercise_sessions/1
  # PUT /exercise_sessions/1.xml
  def update
    @exercise_session = ExerciseSession.find(params[:id])

    respond_to do |format|
      if @exercise_session.update_attributes(params[:exercise_session])
        format.html { redirect_to(@exercise_session, :notice => 'Exercise session was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exercise_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /exercise_sessions/1
  # DELETE /exercise_sessions/1.xml
  def destroy
    @exercise_session = ExerciseSession.find(params[:id])
    @exercise_session.destroy

    respond_to do |format|
      format.html { redirect_to(exercise_sessions_url) }
      format.xml  { head :ok }
    end
  end
end
