# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :environments do
      primary_key :id
      foreign_key :project_id, :projects, on_delete: :cascade, null: false

      column :name, String, null: false

      column :api_key, String, null: false, unique: true
      column :color, String, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index %i[name project_id], unique: true
    end
  end
end
