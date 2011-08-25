require 'sinatra'
require 'redis'
require 'sinatra/reloader'
require 'net/http'
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

get '/' do
  uri = URI.parse('http://localhost:4567/hello/somebody')
  response = Net::HTTP.get_response(uri)
  return response.body
end

