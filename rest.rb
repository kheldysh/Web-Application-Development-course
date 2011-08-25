require 'sinatra'
require 'redis'
require 'sinatra/reloader'

before do
  @redis = Redis.new
end

# generic string service

put '/:key' do
  @redis.set params[:key], params[:value]
end

get '/:key' do
  value = @redis.get params[:key]
  if value
    return value
  else
    status 404
  end
end

delete '/:key' do
  keys_deleted = @redis.del params[:key]
  if keys_deleted == 1 # isn't checking for 1 a bit volatile?
    ""
  else
    status 404
  end
end

# greeting service

post '/greetings' do
  id = @redis.incr 'greeting_id'
  puts id
  puts "greetings:#{id}"
  @redis.set "greetings:#{id}", params[:greeting]
  return id.inspect
end

get '/greetings/:id' do
  id = params[:id]
  value = @redis.get "greetings:#{id}"
  puts "greetings:#{id}"
  if value
    return value
  else
    status 404
  end
end

delete '/greetings/:id' do
  id = params[:id]
  keys_deleted = @redis.del "greetings:#{id}"
  if keys_deleted == 1 # isn't checking for 1 a bit volatile?
    ""
  else
    status 404
  end
end
