require 'sinatra'
require 'redis'
require 'sinatra/reloader'

before do
  @redis = Redis.new
end

get '/hello/*' do
  string = "Hello,"
  if params[:splat][0].length > 0
    string = string +" "+params[:splat][0]
  end
  if params[:with]
    string = string +" with "+params[:with]
  end
  return string
end

