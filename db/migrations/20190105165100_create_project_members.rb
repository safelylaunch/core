# frozen_string_literal: true

Hanami::Model.migration do
  change do
    extension :pg_enum

    create_enum(:project_member_roles, %w[admin member])

    create_table :project_members do
      primary_key :id

      foreign_key :project_id, :projects, on_delete: :cascade, null: false
      foreign_key :account_id, :accounts, on_delete: :cascade, null: false

      column :role, 'project_member_roles', null: false, default: 'member'

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
