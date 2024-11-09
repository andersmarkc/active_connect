# test/models/active_connect_data_test.rb
require "test_helper"


class ActiveConnectDataTest < ActiveSupport::TestCase
  test "can create ActiveConnectData" do
    data = ActiveConnect::Data.create(run_at: Time.now, status: 1)
    assert data.persisted?, "Expected data to be saved in the database"
  end
end
