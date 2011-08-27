require 'redis'

redis = Redis.new
print "Waiting for work"
while true do
  if work = redis.lpop("workqueue")
    puts "\nGOT WORK! #{work}"
  end
  print "."
  sleep 1
end

