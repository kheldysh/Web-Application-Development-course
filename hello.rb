require 'sinatra'
require 'redis'
require 'sinatra/reloader'

before do
  @redis = Redis.new
end

post '/hello' do
  @redis.set 'hello', params[:who]
  'ok' # implicit return statement
end

get '/hello' do
  @redis.get 'hello' # lessee if implicit return works here
end

get '/redis' do
  @redis.set 'hello', 'world'
  raise 'is this thing on?'
  value = @redis.get 'hello'
  return value
end

get '/' do
  'Hello, world!'
end


