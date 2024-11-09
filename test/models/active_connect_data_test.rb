# test/models/active_connect_data_test.rb
require "test_helper"

class ActiveConnectDataTest < ActiveSupport::TestCase
  def setup
    # Create a product to associate with ActiveConnectData
    @product = Product.create(name: "Test Product", not_url: "http://example.com")
  end

  test "can create ActiveConnectData" do
    # Create ActiveConnectData associated with the product
    data = ActiveConnect::ActiveConnectData.new(
      service: "http_party",
      run_at: Time.now,
      status: 1,
      connectable: @product
    )

    assert data.save!, "Expected data to be saved in the database"
    assert_equal @product, data.connectable, "Expected data to be associated with the product"
  end

  test "validates presence of service" do
    data = ActiveConnect::ActiveConnectData.new(connectable: @product, run_at: Time.now, status: 1, service: nil)
    assert_not data.valid?, "Expected validation to fail when service is nil"
    assert_includes data.errors[:service], "can't be blank"
  end

  test "connected? method returns true when association exists" do
    data = ActiveConnect::ActiveConnectData.create(
      service: "http_party",
      run_at: Time.now,
      status: 1,
      connectable: @product
    )

    # Assuming a `connected?` method is defined as `scrape_connected?` for `Product`
    assert @product.connection_connected?, "Expected product to have a connected scrape"
  end

  test "connected? method returns false when no association exists" do
    assert_not @product.connection_connected?, "Expected product to have no connected scrape"
  end
end
