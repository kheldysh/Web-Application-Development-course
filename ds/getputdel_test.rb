require 'integreat'
require 'curlser'

Integreat "Key-Value Store" do
 
 Test "Basic operations with keys" do
       Step "Setup a client for localhost, port 4567" do
     @client = Curlser.new "http://localhost:4567"
     @client.delete_all_responses!
   end

   Step "Ensure clean database by DELETE /keys/somekey" do
     @client.delete "/keys/somekey"
   
     assert(true, ["200", "404"].include?(@client.responses.last.status))
   end
   
   Step "Verify that /keys/somekey is not found anymore" do
     @client.get "/keys/somekey"
   
     assert("404", @client.responses.last.status)      
   end
   
   Step "Setting a PUT /keys/somekey with value 'somevalue'" do
     @client.put "/keys/somekey", { "value" => "somevalue" }
     
     assert("200", @client.responses.last.status)
   end

   Step "Verify that /keys/somekey is set" do
     @client.get "/keys/somekey"
   
     assert("200", @client.responses.last.status)      
     assert("somevalue", @client.responses.last.body)
   end
   
   Step "DELETE /keys/somekey deletes the key" do
     @client.delete "/keys/somekey"
     assert("200", @client.responses.last.status)      
   end
   
   Step "Now /keys/somekey should be gone" do
     @client.get "/keys/somekey"
     assert("404", @client.responses.last.status)
   end
 
 end
 
end
