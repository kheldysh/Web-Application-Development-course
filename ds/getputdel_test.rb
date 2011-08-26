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
 
Integreat "Integers" do
  
  Test "incrementing and decrementing" do
    
    Step "Ensure that key is empty by DELETE /keys/someinteger" do
      # @client = Curlser.new "http://localhost:4567"
      @client.delete_all_responses!
      @client.delete "/keys/someinteger"
      assert(true, ["200", "404"].include?(@client.responses.last.status))
    end
    
    Step "Verify that key is empty by GET" do
      @client.get "/keys/someinteger"
      assert("404", @client.responses.last.status)
    end
    
    Step "Increment a key" do
      @client.post "/keys/someinteger/increment"
      assert("200", @client.responses.last.status)
    end
    
    Step "Increment a key second time" do
      @client.post "/keys/someinteger/increment"
      @client.get "/keys/someinteger"
      assert("2", @client.responses.last.body)
    end
    
    Step "Decrement a key" do
      @client.post "/keys/someinteger/decrement"
      assert("200", @client.responses.last.status)
    end
    
    Step "Decrement a key second time" do
      @client.post "/keys/someinteger/decrement"
      @client.get "/keys/someinteger"
      assert("0", @client.responses.last.body)
    end    
    
  end
    
end

Integreat "List operations" do
  
  Test "Adding to list" do
    
    Step "Ensure that shopping list is empty by DELETE /lists/shoppinglist" do
      @client.delete_all_responses!
      @client.delete "/lists/shoppinglist"
      assert(true, ["200", "404"].include?(@client.responses.last.status))
    end
    
    Step "Adding 'apples' to the list with POST /lists/shoppinglist?value=apples" do
      @client.post "/lists/shoppinglist", {"value"=>"apples"}
      assert("200", @client.responses.last.status)
    end

    Step "Adding 'oranges' to the list" do
      @client.post "/lists/shoppinglist", {"value"=>"oranges"}
      assert("200", @client.responses.last.status)
    end

    Step "Adding 'bananas' to the list" do
      @client.post "/lists/shoppinglist", {"value"=>"bananas"}
      assert("200", @client.responses.last.status)
    end

    Step "Adding 'coconuts' to the list" do
      @client.post "/lists/shoppinglist", {"value"=>"coconuts"}
      assert("200", @client.responses.last.status)
    end
    
  end
  
  Test "Removing from list" do
    
    Step "Popping the last item with DELETE /lists/shoppinglist/pop should give 'coconuts' from the list" do
      @client.delete "/lists/shoppinglist/pop"
      assert("200", @client.responses.last.status)
    end
    
    Step "Check that we got coconuts" do
      assert("coconuts", @client.responses.last.body)
    end
    
    Step "Next item should be bananas" do
      @client.delete "/lists/shoppinglist/pop"
      assert("bananas", @client.responses.last.body)
    end

    Step "Next item should be oranges" do
      @client.delete "/lists/shoppinglist/pop"
      assert("oranges", @client.responses.last.body)
    end

    Step "Next item should be apples" do
      @client.delete "/lists/shoppinglist/pop"
      assert("apples", @client.responses.last.body)
    end        
    
    Step "List should now be empty (DELETE /lists/shoppinglist/pop returns \"\")" do
      @client.delete "/lists/shoppinglist/pop"
      assert("", @client.responses.last.body)
    end
    
  end
  
  Test "List knows its length" do
    
    Step "Ensure that list doesn't contain old values by DELETE /lists/shoppinglist" do
      @client.delete '/lists/shoppinglist'
      assert(true, ["200", "404"].include?(@client.responses.last.status))
    end
    
    Step "Add 2 items to list with POST /lists/shoppinglist?value=titanic and POST /lists/shoppinglist?value=sputnik" do
      @client.post "/lists/shoppinglist", {"value" => "titanic"}
      @client.post "/lists/shoppinglist", {"value" => "sputnik"}
    end
    
    Step "Length of list is now '2' when GET /lists/shoppinglist/length" do
      @client.get "/lists/shoppinglist/length"
      assert("200", @client.responses.last.status)
    end
    
    Step "Check that returned length is '2'" do
      assert("2", @client.responses.last.body)
    end
    
    Step "Delete the whole list with DELETE /lists/shoppinglist" do
      @client.delete "/lists/shoppinglist"
    end
    
    Step "Length of list is now '0' when GET /lists/shoppinglist/length" do
      @client.get "/lists/shoppinglist/length"
      assert("0", @client.responses.last.body)
    end
   
  end

end
