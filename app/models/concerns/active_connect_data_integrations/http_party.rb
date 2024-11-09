# frozen_string_literal: true
# Path: app/models/concerns/active_connect_data_integrations/http_party.rb

require "httparty"

module ActiveConnectDataIntegrations
  module HttpParty
    extend ActiveSupport::Concern

    included do
      include HTTParty  # Include HTTParty to use its methods within the concern
    end

    # Example method that makes an HTTP GET request
    def fetch_data(endpoint, options = {})
      self.class.get(endpoint, options)
    end
  end
end
