# frozen_string_literal: true
# Path: lib/active_connect/engine.rb

module ActiveConnect
  class Engine < ::Rails::Engine
    isolate_namespace ActiveConnect

    initializer "active_connect.model_additions" do
      ActiveSupport.on_load(:active_record) do
        include ActiveConnect
      end
    end
  end
end
