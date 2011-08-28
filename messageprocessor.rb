require 'redis'

redis = Redis.new

while true do
  sleep 1
  if q_msg = redis.lpop("workqueue-messages")
    redis.rpush "messages", q_msg
    redis.set "messages_last_updated_at", Time.now.to_i
  end
end  


