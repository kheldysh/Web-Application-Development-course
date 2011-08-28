require 'integreat'
require 'curlser'

Integreat "Wordcount service" do

  Test "Counting submitted words" do

    Step "Initialize browser" do
      @browser = Curlser.new "http://localhost:4567"
      @browser.delete_all_responses!
    end

    Step "Ensure clean database by DELETE /words/key" do
      @browser.delete "/words/key"
      assert(true, ["200", "404"].include?(@browser.responses.last.status))
    end
    
    Step "'key' does not exist now" do
      @browser.get "/words/key"
      assert("404", @browser.responses.last.status)
    end

    Step "Verify existence of submission form" do
      @browser.get "/"
      assert(true, @browser.responses.last.body.include?('/words" method="POST"'))
    end

    Step "Submit a word by POST /words?word=key" do
      @browser.post "/words", { "word" => "key" }
      assert("302", @browser.responses.last.status)
    end
    
    Step "Verify that word is count" do
      @browser.get "/words/key"
      assert("1", @browser.responses.last.body)
    end
      
    Step "Increment 'key' 3 times" do
      3.times do
        @browser.post "/words", { "word" => "key" }
      end
      assert("302", @browser.responses.last.status)
    end

    Step "Word count for 'key' is now 4" do
      @browser.get "/words/key"
      assert("4", @browser.responses.last.body)
    end
    
  end

end
