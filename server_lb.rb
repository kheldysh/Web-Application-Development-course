# LOAD BALANCER

require 'sinatra'
require 'redis'
require 'sinatra/reloader'
require 'net/http'

enable :sessions

before do
  if not session[:server_for_this_session]
    servers = ['http://localhost:10000', 'http://localhost:10001']
    random_index = rand(servers.length)
    session[:server_for_this_session] = servers[random_index] # forward randomly
  end
end

get '/session' do
  session[:testing] = 'hello'
end

get '*' do
  server = session[:server_for_this_session]
  path = params[:splat][0] # first member of array should be the path
  uri = URI.parse(server + path)
  response = Net::HTTP.get_response(uri)
  return response.body
end
