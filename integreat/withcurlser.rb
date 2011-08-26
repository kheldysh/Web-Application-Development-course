require 'integreat'
require 'curlser'

Integreat "Remote testing" do
  
  Test "We get greeted" do
  
    Step "Initialize a browser" do
      @browser = Curlser.new "http://localhost:4567"
    end
    
    Step "Request a greeting from a web app" do
      @browser.get "/hello/integreator"
      
      assert("200", @browser.responses.last.status)
    end
    
    Step "See that the greeting is correct" do
      assert("Hello, integreator", @browser.responses.last.body)
    end
  
  end

  Test "Also other paths work" do
    
    Step "Initialize a browser" do
      @browser = Curlser.new "http://localhost:4567"
    end
    
    Step "The root greets somebody" do
      @browser.get "/"
      assert("200", @browser.responses.last.status)
    end
    
    Step "Root response is correct" do
      assert("Hello, somebody", @browser.responses.last.body)
    end
    
    Step "Hello greets a path parameter" do
      @browser.get "/hello/unknown"
      assert("200", @browser.responses.last.status)
    end
    
    Step "Path parameter is handled correctly" do
      assert("Hello, unknown", @browser.responses.last.body)
    end
    
    Step "Hello greets a path with key parameters" do
      @browser.get "/hello/unknown?with=secrets"
      assert("200", @browser.responses.last.status)
    end
    
    Step "Path and key parameters are handled correctly" do
      assert("Hello, unknown with secrets", @browser.responses.last.body)
    end    
    
  end
  
end
