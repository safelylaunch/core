# frozen_string_literal: true

class AuthIdentity < Hanami::Entity
end

class Project < Hanami::Entity
end

class Account < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :auth_identities, Types::Collection(AuthIdentity)
    attribute :projects, Types::Collection(Project)

    attribute :name, Types::String
    attribute :uuid, Types::String
    attribute :email, Types::String
    attribute :avatar_url, Types::String
    attribute :role, Core::Types::AccountRoles

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
