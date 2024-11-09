class Product < ApplicationRecord
  has_one_connect :connection, service: :http_party, dependent: :destroy
end
