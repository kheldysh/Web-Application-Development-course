require 'net/http'
require 'redis'

redis = Redis.new

while true do
  if work_uri = redis.lpop("to-be-fetched")
    print "Fetching #{work_uri}\n"
    uri = URI.parse(work_uri)
    response = Net::HTTP.get_response(uri)
    redis.set work_uri, response.body
    print "Finished."
  end
  print "."
  sleep 1
end  


