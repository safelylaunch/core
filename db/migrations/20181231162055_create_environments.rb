# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :environments do
      primary_key :id

      column :name, String, null: false

      column :api_key, String, null: false, unique: true
      column :color, String, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
