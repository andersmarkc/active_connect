# frozen_string_literal: true
# lib/generators/active_connect/templates/create_active_connect_data.rb
#
class CreateActiveConnectActiveConnectData < ActiveRecord::Migration[7.0]
  def change
    create_table :active_connect_active_connect_data do |t|
      t.references :connectable, polymorphic: true, index: true
      t.json :data
      t.datetime :run_at
      t.integer :status
      t.string :service
      t.timestamps
    end
  end
end
