# LOAD BALANCER

require 'sinatra'
require 'redis'
require 'sinatra/reloader'
require 'net/http'

get '*' do
  servers = ['http://localhost:10000', 'http://localhost:10001']
  random_index = rand(servers.length)
  server = servers[random_index] # forward randomly
  path = params[:splat][0] # first member of array should be the path
  uri = URI.parse(server + path)
  response = Net::HTTP.get_response(uri)
  return response.body
end
