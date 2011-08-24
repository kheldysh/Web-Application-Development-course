require 'sinatra'
require 'redis'
require 'sinatra/reloader'

get '/redis' do
  redis = Redis.new
  redis.set "hello", "world"
  raise 'is this thing on?'
  value = redis.get "hello"
  return value
end

get '/' do
  "Hello, world!"
end


