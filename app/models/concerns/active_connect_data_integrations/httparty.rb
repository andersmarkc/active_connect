# frozen_string_literal: true
# Path: app/models/concerns/active_connect_data_integrations/http_party.rb

require "httparty"

module ActiveConnectDataIntegrations
  module Httparty
    extend ActiveSupport::Concern

    included do
      include HTTParty  # Include HTTParty to use its methods within the concern
    end

    def httpparty_update_data
      byebug

      puts 'dd'
    end
  end
end
