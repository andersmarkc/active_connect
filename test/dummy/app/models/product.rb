class Product < ApplicationRecord
  has_one_connect :scrape, service: :http_party, dependent: :destroy
end
