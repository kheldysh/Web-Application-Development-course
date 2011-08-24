# LOAD BALANCER

require 'sinatra'
require 'redis'
require 'sinatra/reloader'
require 'net/http'

get '*' do
  server_a = 'http://localhost:10000'
  path = params[:splat][0] # first member of array should be the path
  uri = URI.parse(server_a + path)
  response = Net::HTTP.get_response(uri)
  return response.body
end
