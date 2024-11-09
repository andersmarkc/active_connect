class Product < ApplicationRecord
  has_one_connect :connection, service: :http_party, dependent: :destroy

  def parse_data(data)
    # Parse the data from the connection.
  end
end
