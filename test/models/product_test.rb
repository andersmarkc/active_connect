# test/models/product_test.rb
require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "can create product with one connect" do
    product = Product.create(name: "Test Product", not_url: "http://example.com")
    scrape_data = ActiveConnect::ActiveConnectData.create(service: "http_party", connectable: product)

    # Test if the product has a connected scrape
    assert product.connection_connected?, "Expected product to have a connected scrape"
    assert_equal "http_party", product.connection.service
  end

  test "connected? returns false when no connection exists" do
    product = Product.create(name: "Test Product")

    # Test if `connected?` returns false when no connection is present
    assert_not product.connection_connected?, "Expected product to have no connected scrape"
  end
end
