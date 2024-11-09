# frozen_string_literal: true
# Path: lib/tasks/active_connect_tasks.rake

require "active_connect/version"
require "active_connect/engine"

module ActiveConnect
  extend ActiveSupport::Concern

  class_methods do
    def has_connect(connect_name)
      # Define scraping settings or initializations here
      # You can store configurations in connect.yml
    end
  end
end
