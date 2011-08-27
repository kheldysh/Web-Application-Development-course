require 'integreat'
require 'curlser'

Integreat "Load balancer with two servers" do

  Test "Redirection with and without sessions" do

    Step "Initialize browser" do
      @browser = Curlser.new "http://localhost:4567"
    end

    Step "Sticky session leads to only one server" do
      25.times do
        @browser.get "/whoami"
      end
      bodies = @browser.responses.map(&:body)
      unique_bodies = bodies.uniq
      assert(1, unique_bodies.size)
    end

    Step "Sessionless loadbalancing redirects to both servers" do

    25.times do
      @browser.cookie_jar.delete!
      @browser.get "/whoami"
    end
    bodies = @browser.responses.map(&:body)
    unique_bodies = bodies.uniq
    assert(2, unique_bodies.size)

    end

  end

end
