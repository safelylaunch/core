Hanami::Model.migration do
  change do
    extension :pg_enum

    create_enum(:account_roles, %w[user admin])

    create_table :accounts do
      primary_key :id

      column :name,       String
      column :uuid,       String
      column :email,      String
      column :avatar_url, String
      column :role, 'account_roles', null: false, default: 'user'

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
