# frozen_string_literal: true

class Project < Hanami::Entity
end

class Environment < Hanami::Entity
  attributes do
    attribute :id, Types::Int
    attribute :project_id, Types::Int
    attribute :project, Types::Entity(Project)

    attribute :name, Types::String
    attribute :api_key, Core::Types::UUID
    attribute :color, Types::String

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
