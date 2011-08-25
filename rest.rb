require 'sinatra'
require 'redis'
require 'sinatra/reloader'

before do
  @redis = Redis.new
end

post '/greetings' do
  id = @redis.incr 'greeting_id'
  @redis.set 'greetings:#{id}', params[:greeting]
  return id.inspect
end

get '/greetings/:id' do
  id = params[:id]
  value = @redis.get 'greetings:#{id}'
  puts 'greetings:#{id}'
  if value
    return value
  else
    status 404
  end
end
