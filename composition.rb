require 'sinatra'
require 'redis'
require 'sinatra/reloader'
require 'net/http'

Server_A = 'http://localhost:10000'
Server_B = 'http://localhost:10001'
Server_Chat = 'http://localhost:10003'

before do
  @redis = Redis.new
end

post '/messages' do # forward /messages requests to chat 
  uri = URI.parse(Server_Chat + '/messages')
  res = Net::HTTP.post_form(uri, {'message' => params[:message]})
  redirect '/'
end    

get '/' do
  
  path = '/whoami'
  uri = URI.parse(Server_A + path)
  @from_server_a = check_cache(uri, 'server_a')
  uri = URI.parse(Server_B + path)
  @from_server_b = check_cache(uri, 'server_b')
  uri =  URI.parse(Server_Chat)
  @from_chat = get_response_body_from(uri) # don't bother checking cache for chat
  
  erb :composition
end

def check_cache(uri, logical_name)
  cache_key = logical_name+"_output"
  cached_value = @redis.get cache_key
  if not cached_value
    value = get_response_body_from(uri)
    @redis.set cache_key, value
    cached_value = value
  end
  return cached_value
end

def get_response_body_from(uri)
  response = Net::HTTP.get_response(uri)
  return response.body
end
