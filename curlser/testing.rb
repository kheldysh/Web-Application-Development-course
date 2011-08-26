require 'curlser'

browser = Curlser.new "http://localhost:4567"
browser.get "/hello/somebody"
puts browser.responses.last.body
