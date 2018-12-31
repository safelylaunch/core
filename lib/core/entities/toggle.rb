# frozen_string_literal: true

class Environment
end

class Toggle < Hanami::Entity
  attributes do
    attribute :id, Types::Int
    attribute :environment_id, Types::Int
    attribute :environment, Types::Entity(Environment)

    attribute :key, Types::String
    attribute :name, Types::String
    attribute :description, Types::String
    attribute :type, ::Types::ToggleStatuses
    attribute :status, ::Types::ToggleTypes

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
