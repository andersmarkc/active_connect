# frozen_string_literal: true
# Path: app/models/active_scrape/scrape_data.rb

module ActiveConnect
  class ActiveConnectData < ApplicationRecord
    # Integration with HTTParty
    include ActiveConnectDataIntegrations::HttpParty

    # Add a polymorphic association to the connectable model
    belongs_to :connectable, polymorphic: true
    # Add a field for service to differentiate between connection types
    validates :service, presence: true
  end
end
