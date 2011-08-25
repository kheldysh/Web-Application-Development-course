require 'sinatra'
require 'redis'
require 'sinatra/reloader'

before do
  @redis = Redis.new
end

get '/messages' do
  messages = @redis.lrange "messages", -3, -1
  return messages.inspect
end

post '/messages' do
  @redis.rpush "messages", params[:message]
  redirect "chat.html"
end
