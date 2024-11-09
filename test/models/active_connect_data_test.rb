# test/models/active_connect_data_test.rb
require "test_helper"

class ActiveConnectDataTest < ActiveSupport::TestCase
  test "can create ActiveConnectData" do
    # Create a product to associate with ActiveConnectData
    product = Product.create(name: "Test Product")

    # Create ActiveConnectData associated with the product
    data = ActiveConnect::ActiveConnectData.new(service: "http_party", run_at: Time.now, status: 1, connectable: product)

    assert data.save!, "Expected data to be saved in the database"
  end
end
