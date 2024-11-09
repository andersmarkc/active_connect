# frozen_string_literal: true
# Path: app/models/concerns/active_connect_data_integrations/http_party.rb

require "httparty"

module ActiveConnectDataIntegrations
  module Httparty
    extend ActiveSupport::Concern

    def httparty_update_data
      @tries = 0
      options = { headers: headers_settings, timeout: request_timeout }
      options.merge!(proxy_settings) if proxy_settings
      data = send_request(options)
      data = { status: data.code, body: data.body }
      save_data(data)
      data
    end

    private

    def save_data(data)
      data[:status] == 200 ? update_data_success : update_data_failed
      update(data: data)
    end

    def send_request(options)
      sleep(request_sleep) if request_sleep.positive?
      HTTParty.send(request_type, request_url, options)
    rescue StandardError => e
      retry if (@tries += 1) < request_retries
      raise e
    end

    def proxy_settings
      base_proxy_settings = {}
      proxy_settings = load_service_config.dig('proxy')
      return unless proxy_settings
      proxy_split = proxy_settings.split(':')
      return unless proxy_split.size > 1

      base_proxy_settings[:http_proxyaddr] = proxy_split[0]
      base_proxy_settings[:http_proxyport] = proxy_split[1]
      return base_proxy_settings unless proxy_split.size == 4

      base_proxy_settings[:http_proxyuser] = proxy_split[2]
      base_proxy_settings[:http_proxypass] = proxy_split[3]
      base_proxy_settings
    end

    def headers_settings
      base_headers = {}
      headers_settings = load_service_config.dig('request_headers')
      return unless headers_settings

      headers_settings.each do |header_key, header_value|
        base_headers[header_key] = header_value
      end
      base_headers
    end
  end
end
