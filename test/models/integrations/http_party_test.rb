# test/models/integrations/http_party_test.rb
require "test_helper"
require "json"

class HttpPartyIntegrationTest < ActiveSupport::TestCase
  def setup
    @product = Product.create(name: "Test Product", not_url: "https://postman-echo.com/get")
    @data = ActiveConnect::ActiveConnectData.create(service: "http_party", connectable: @product)
  end

  def parsed_response_data
    JSON.parse(@data.reload.data["body"])
  end

  test "can make an HTTP request with default parameters" do
    @data.update_data
    response_data = parsed_response_data
    assert_equal 200, @data.reload.data["status"], "Expected HTTP status to be 200"
    assert_equal "https://postman-echo.com/get", response_data["url"], "Expected response URL to match default URL"
  end

  test "can make an HTTP request with a custom URL" do
    @data.update_data(custom_url: "https://postman-echo.com/get?test=custom_url")
    response_data = parsed_response_data
    assert_equal 200, @data.reload.data["status"], "Expected HTTP status to be 200"
    assert_equal "https://postman-echo.com/get?test=custom_url", response_data["url"], "Expected response URL to match custom URL"
  end

  test "can make an HTTP request with a custom request type" do
    @data.update_data(custom_request_type: :post, custom_body: { test: "data" }, custom_url: "https://postman-echo.com/post")
    response_data = parsed_response_data
    assert_equal 200, @data.reload.data["status"], "Expected HTTP status to be 200"
    assert_equal "data", response_data["form"]["test"], "Expected response form data to include 'test' key with value 'data'"
  end

  test "can make an HTTP request with custom headers" do
    custom_headers = { "Authorization" => "Bearer test_token" }
    @data.update_data(custom_headers: custom_headers, custom_url: "https://postman-echo.com/get")
    response_data = parsed_response_data
    assert_equal 200, @data.reload.data["status"], "Expected HTTP status to be 200"
    assert_equal "Bearer test_token", response_data["headers"]["authorization"], "Expected response headers to include custom Authorization header"
  end

  test "can make an HTTP request with custom body" do
    custom_body = { key: "value" }
    @data.update_data(custom_body: custom_body, custom_request_type: :post, custom_url: "https://postman-echo.com/post")
    response_data = parsed_response_data
    assert_equal 200, @data.reload.data["status"], "Expected HTTP status to be 200"
    assert_equal "value", response_data["form"]["key"], "Expected response form data to include 'key' with value 'value'"
  end

  test "can handle failed HTTP requests with retries" do
    begin
      # Using an invalid URL to force a failure and trigger retries
      @data.update_data(custom_url: "https://invalid-url.com")
    rescue StandardError => e
      # Optionally, log or inspect the error if needed
      Rails.logger.info "Expected error occurred: #{e.message}"
    end

    assert_equal "failed", @data.reload.status, "Expected product connection status to be failed after retries"
  end
end
