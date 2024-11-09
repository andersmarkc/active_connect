require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "can create product with one connect" do
    product = Product.create(name: "Test Product")
    scrape_data = ActiveConnect::ActiveConnectData.create(service: "http_party", connectable: product)

    assert product.scrape.present?, "Expected product to have a connected scrape"
    assert_equal "http_party", product.scrape.service
  end
end
