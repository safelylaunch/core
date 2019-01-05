# frozen_string_literal: true

Hanami::Model.migration do
  change do
    extension :pg_enum

    create_enum(:auth_identity_types, %w[google])

    create_table :auth_identities do
      primary_key :id
      foreign_key :account_id, :accounts, on_delete: :cascade

      column :uid,   String
      column :token, String
      column :type, 'auth_identity_types', null: false, default: 'google'

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
