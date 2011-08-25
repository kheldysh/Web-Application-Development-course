require 'sinatra'
require 'sinatra/reloader'
require 'redis'

before do
  @redis = Redis.new
end

post '/greetings' do
  id = @redis.incr 'greeting_id'
  @redis.set 'greetings:#{id}', params[:greeting]
  return id.inspect
end


