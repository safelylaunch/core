# frozen_string_literal: true

class Project < Hanami::Entity
end

class Account < Hanami::Entity
end

class ProjectMember < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :project_id, Types::Int
    attribute :project, Types::Entity(Project)

    attribute :account_id, Types::Int
    attribute :account, Types::Entity(Account)

    attribute :role, ::Types::ProjectMemberRoles

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
