require 'sinatra'
require 'redis'
require 'sinatra/reloader'

# set :port, 10_003

enable :sessions

before do

  @redis = Redis.new
  use Rack::Auth::Basic do |username,password|
    username == 'joe' && password == 'd34db33f'
  end

end

def take_it_slow_now(secs)
  @redis.lpush 'workqueue', secs
end

get '/cachetesting' do
  etag "unique-2"
  puts "About to do something really slow"
  sleep 1
  puts "still doing it"
  sleep 1
  puts "not quite finished"
  sleep 1
  puts "wow this is a big task"
  sleep 1
  
  return "Finished at " + Time.now.to_s
end

get '/messages' do
  messages = @redis.lrange "messages", -20, -1
  return messages.inspect
end

post '/messages' do
  @redis.rpush "workqueue-messages", params[:message]
  session[:last_message_that_has_not_yet_been_written_to_database] = params[:message]
  @redis.set "messages_last_updated_at", Time.now.to_i
  redirect "/"
end

get '/' do
  etag @redis.get "messages_last_updated_at"
  @messages = @redis.lrange "messages", -20, -1
  if session[:last_message_that_has_not_yet_been_written_to_database]
    @messages << session[:last_message_that_has_not_yet_been_written_to_database]
    session[:last_message_that_has_not_yet_been_written_to_database] = nil
  end

  # take_it_slow_now(4)
  erb :chat
end
