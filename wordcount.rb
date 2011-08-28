require 'sinatra'
require 'redis'
require 'sinatra/reloader'

before do
  @redis = Redis.new
end

get '/words/:word' do
  count = @redis.get params[:word]
  if count
    return count
  else
    status 404
  end
end

delete '/words/:word' do
  keys_deleted = @redis.del params[:word]
  if keys_deleted == 1
    ""
  else
    status 404
  end
end

post '/words' do
  @redis.incr params[:word]
  redirect "/"
end

get '/' do
  erb :wordcount
end
