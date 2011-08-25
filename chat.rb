require 'sinatra'
require 'redis'
require 'sinatra/reloader'

before do
  @redis = Redis.new
end

def take_it_slow_now(secs)
  puts "this ain't a race"
  sleep secs
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
  messages = @redis.lrange "messages", -3, -1
  return messages.inspect
end

post '/messages' do
  @redis.rpush "messages", params[:message]
  @redis.set "messages_last_updated_at", Time.now.to_i
  redirect "/"
end

get '/' do
  etag @redis.get "messages_last_updated_at"
  @messages = @redis.lrange "messages", -3, -1
  take_it_slow_now(4)
  erb :chat
end
