require 'sinatra'
require 'redis'
require 'sinatra/reloader'
require 'net/http'

Server_A = 'http://localhost:10000'
Server_B = 'http://localhost:10001'
Server_Chat = 'http://localhost:10003'

post '/messages' do # forward /messages requests to chat 
  uri = URI.parse(Server_Chat + '/messages')
  res = Net::HTTP.post_form(uri, {'message' => params[:message]})
  redirect '/'
end
    

get '/' do
  path = '/whoami'
  uri = URI.parse(Server_A + path)
  @from_server_a = get_response_body_from(uri)
  uri = URI.parse(Server_B + path)
  @from_server_b = get_response_body_from(uri)
  uri =  URI.parse(Server_Chat)
  @from_chat = get_response_body_from(uri)
  
  erb :composition
end

def get_response_body_from(uri)
  response = Net::HTTP.get_response(uri)
  return response.body
end
