# frozen_string_literal: true
# Path: lib/active_connect.rb

require "active_connect/version"
require "active_connect/engine"

module ActiveConnect
  extend ActiveSupport::Concern

  class_methods do
    def has_one_connect(name, service:, dependent: :nullify)
      # Define an association similar to ActiveStorage's `has_one_attached`
      has_one :"#{name}_data", -> { where(service: service) }, class_name: "ActiveConnect::ActiveConnectData", as: :connectable, dependent: dependent

      # Define a method to access the connection service
      define_method(name) do
        public_send("#{name}_data")
      end

      # Define a `connected?` method to check if a connection exists
      define_method("#{name}_connected?") do
        public_send("#{name}_data").present?
      end
    end
  end
end
