# frozen_string_literal: true
# Path: lib/active_connect/engine.rb

module ActiveConnect
  class Engine < ::Rails::Engine
    isolate_namespace ActiveConnect
  end
end
