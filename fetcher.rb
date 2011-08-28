require 'sinatra'
require 'redis'
require 'sinatra/reloader'

enable :sessions

before do
  @redis = Redis.new
end

post '/fetch' do
  @redis.lpush "to-be-fetched", params[:url]
  session["to-be-fetched"] = params[:url]
  redirect '/waiting'
end

get '/waiting' do
  if @content = @redis.get(session["to-be-fetched"])
    erb :got_content
  else
    erb :waiting
  end
end

get '/' do
  erb :giveurl
end
