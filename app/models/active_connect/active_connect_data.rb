# frozen_string_literal: true
# app/models/active_connect/active_connect_data.rb

require 'yaml'

module ActiveConnect
  class ActiveConnectData < ApplicationRecord
    # Include the HTTParty module for making HTTP requests
    include ActiveConnectDataIntegrations::Httparty
    # Define the polymorphic association to the connectable model
    belongs_to :connectable, polymorphic: true

    # Validate the presence of the service attribute
    validates :service, presence: true

    # enum status
    enum :status, [:success, :failed]

    # Master method to fetch data from the service
    def update_data
      config = load_service_config  # Load the service-specific configuration
      method_name = "#{config['engine']}_update_data"

      if respond_to?(method_name, true)
        send(method_name, config)
      else
        raise NoMethodError, "No method defined for engine '#{config['engine']}'"
      end
    end

    # Load service-specific configuration from the YAML file
    def load_service_config
      config = load_yaml_config
      # Validate the service exists in the YAML config
      raise "Service '#{service}' not found in configuration" unless config.key?(service)
      config[service]
    end

    private

    # Update the status to error and set the run_at timestamp
    def update_data_failed
      update(status: :error, run_at: Time.current)
    end

    # Update the status to success and set the run_at timestamp
    def update_data_success
      update(status: :success, run_at: Time.current)
    end

    # Define the number of request retries defaulting to 0
    def request_retries
      load_service_config.dig('request_retries') || 0
    end

    # Define the sleep time between requests defaulting to 0 seconds
    def request_sleep
      load_service_config.dig('sleep') || 0
    end

    # Define the request timeout defaulting to 60 seconds
    def request_timeout
      load_service_config.dig('timeout') || 60
    end

    # Define the request type defaulting to 'get'
    def request_type
      load_service_config.dig('request_type') || 'get'
    end

    # Define the URL to request data from defaulting to the 'url' column
    def request_url
      connectable[load_service_config.dig('url_column') || 'url']
    end

    # Load the YAML file and handle any errors in locating or parsing it
    def load_yaml_config
      config_path = Rails.root.join('config', 'connect.yml')
      YAML.load_file(config_path, aliases: true)
    rescue Errno::ENOENT
      raise "Configuration file 'connect.yml' not found"
    rescue Psych::SyntaxError => e
      raise "YAML syntax error occurred while parsing connect.yml: #{e.message}"
    end
  end
end
