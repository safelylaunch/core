# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :projects do
      primary_key :id
      foreign_key :owner_id, :accounts, on_delete: :cascade, null: false

      column :name, String, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index %i[name owner_id], unique: true
    end
  end
end
