# test/models/integrations/http_party_test.rb
require "test_helper"

class HttpPartyIntegrationTest < ActiveSupport::TestCase
  def setup
    @product = Product.create(name: "Test Product", not_url: "https://api.ipify.org?format=json")
    @data = ActiveConnect::ActiveConnectData.create(service: "http_party", connectable: @product)
  end

  test "can make an HTTP request" do
    @product.connection.update_data

    # Test if the data was successfully updated
    assert @data.reload.status, "Expected product connection status to be success"
    assert_equal "success", @data.reload.status
  end
end
