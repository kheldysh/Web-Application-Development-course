require 'integreat'
require 'curlser'

Integreat "Chat Service with Authorization" do

  Test "Authorization and message posting" do

    Step "Unauthorized access is blocked" do
      browser = Curlser.new "http://localhost:4567"
      browser.get "/"
      assert("401", browser.responses.last.status)
    end

    Step "Start authorized connection" do
      @browser = Curlser.new "http://joe:d34db33f@localhost:4567"
      @browser.delete_all_responses!     
    end   

    Step "Root page has POST form for /messages" do # depends on the order of html attributes in source :(
      @browser.get "/"
      assert(true, @browser.responses.last.body.include?('/messages" method="POST"'))
    end

    Step "Send three similar messages as POST to /messages - get redirected" do
      3.times do
        @browser.post "/messages", { "message" => "Hallo, Berlin" }
      end      
      assert("302", @browser.responses.last.status)
    end

    Step "Send one more message and get redirected" do
      @browser.post "/messages", { "message" => "Hello, Helsinki" }
      assert("302", @browser.responses.last.status)
    end

    Step "The last message is visible in root" do
      @browser.get "/"
      assert(true, @browser.responses.last.body.include?("Hello, Helsinki"))
    end
  
  end

end
