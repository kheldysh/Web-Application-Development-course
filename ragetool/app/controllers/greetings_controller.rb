class GreetingsController < ApplicationController

  def index
    @string_for_template = "All greetings"
  end

  def show
    @value = $redis.get "greetings:#{params[:id]}"
  end

  def create
    id = @redis.incr 'greeting_id'
    puts id
    puts "greetings:#{id}"
    @redis.set "greetings:#{id}", params[:greeting]
    return id.inspect
  end
  
  def put
    $redis.set params[:id], params[:greeting]
  end
  
  def delete
    keys_deleted = @redis.del params[:key]
    if keys_deleted == 1 # isn't checking for 1 a bit volatile?
      ""
    else
      status 404
    end
  end
  
end
