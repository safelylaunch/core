# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :toggle_counters do
      primary_key :id
      foreign_key :toggle_id, :toggles, on_delete: :cascade

      column :count,      Integer

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
