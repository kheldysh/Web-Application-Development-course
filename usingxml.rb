require 'net/http'
require 'nokogiri'

uri = URI.parse("http://localhost:3000/exercises.xml")
response = Net::HTTP.get_response(uri)

puts "Exercises available:"

doc = Nokogiri::XML(response.body)

doc.xpath('/exercises/exercise/tag').each do |tag|
  puts tag.text
end
