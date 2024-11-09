# test/models/integrations/http_party_test.rb
require "test_helper"

class HttpPartyIntegrationTest < ActiveSupport::TestCase
  def setup
    @product = Product.create(name: "Test Product")
    @data = ActiveConnect::ActiveConnectData.create(service: "http_party", connectable: @product)
  end

  test "can make an HTTP request" do
    @product.connection.httpparty_update_data
  end
end
