# frozen_string_literal: true

class Environment < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :name, Types::String
    attribute :api_key, Types::String
    attribute :color, Types::String

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
