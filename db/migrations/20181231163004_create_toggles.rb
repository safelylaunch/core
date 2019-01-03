# frozen_string_literal: true

Hanami::Model.migration do
  change do
    extension :pg_enum

    create_enum(:toggle_types, %w[boolean])
    create_enum(:toggle_statuses, %w[enable disable])

    create_table :toggles do
      primary_key :id

      foreign_key :environment_id, :environments, on_delete: :cascade, null: false

      # trigger on not space chars
      column :key,  String, null: false

      column :name, String, null: false
      column :description, String, text: true

      column :type, 'toggle_types', null: false, default: 'boolean'
      column :status, 'toggle_statuses', null: false, default: 'disable'
      column :default_status, 'toggle_statuses', null: false, default: 'disable'

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index %i[key environment_id], unique: true
    end
  end
end
