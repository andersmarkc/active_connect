# test/models/integrations/http_party_test.rb
require "test_helper"

class HttpPartyIntegrationTest < ActiveSupport::TestCase
  def setup
    @product = Product.create(name: "Test Product")
    @data = ActiveConnect::ActiveConnectData.create(service: "http_party", connectable: @product)
  end

  test "can make an HTTP request" do
    # Use stubbing here to test HTTParty methods without real requests
    ActiveConnectDataIntegrations::HttpParty.stub(:get, {status: 200}) do
      response = @data.perform_request
      assert_equal 200, response[:status], "Expected status to be 200"
    end
  end
end
