# frozen_string_literal: true
# lib/generators/active_connect/install_generator.rb

module ActiveConnect
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    source_root File.expand_path("templates", __dir__)

    # Implement the required interface for Rails::Generators::Migration.
    def self.next_migration_number(dirname)
      if @migration_number
        @migration_number += 1
      else
        @migration_number = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
      end
      @migration_number.to_s
    end

    def copy_scrape_yml
      template "connect.yml", Rails.root.join("config/connect.yml")
    end

    def copy_migrations
      migration_template "create_active_connect_active_connect_data.rb", Rails.root.join("db/migrate/create_active_connect_active_connect_data.rb")
    end

    def add_require_to_application
      inject_into_file Rails.root.join("config/application.rb"), "\nrequire 'active_connect'", after: "Bundler.require(*Rails.groups)"
    end
  end
end
