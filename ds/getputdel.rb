require 'sinatra'
require 'redis'
require 'sinatra/reloader'

before do
  @redis = Redis.new    

  use Rack::Auth::Basic do |username,password|
    username == 'admin' && password == 'secret'
  end
  
end

get '/lists/:key/length' do
  len = @redis.llen params[:key]
  return len.inspect
end

delete '/lists/:key/pop' do
  @redis.rpop params[:key]
end

delete '/lists/:key' do
  @redis.del params[:key]
end

post "/lists/:key" do
  @redis.rpush params[:key], params[:value]
end

post "/keys/:key/increment" do
  @redis.incr params[:key]
end

post "/keys/:key/decrement" do
  @redis.decr params[:key]
end

put '/keys/:key' do
  @redis.set params[:key], params[:value]
end

get '/keys/:key' do
  value = @redis.get params[:key]
  if value
    return value
  else
    status 404
  end
end

delete '/keys/:key' do
  keys_deleted = @redis.del params[:key]
  if keys_deleted == 1 # isn't checking for 1 a bit volatile?
    ""
  else
    status 404
  end
end

get '/' do
  return "Keyservice root"
end
