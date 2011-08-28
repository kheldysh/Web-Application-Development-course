require 'sinatra'
require 'redis'
require 'sinatra/reloader'

before do
  @redis = Redis.new
end

get '/words/:word' do
end

post '/fetch' do
  @redis.lpush "to-be-fetched", params[:url]
  redirect '/waiting'
end

get '/waiting' do
  erb :waiting
end

get '/' do
  erb :giveurl
end
