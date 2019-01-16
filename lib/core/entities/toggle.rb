# frozen_string_literal: true

class Environment < Hanami::Entity
end

class Toggle < Hanami::Entity
  BOOLEAN = 'boolean'
  ENABLE = 'enable'
  DISABLE = 'disable'

  attributes do
    attribute :id, Types::Int
    attribute :environment_id, Types::Int
    attribute :environment, Types::Entity(Environment)

    attribute :key, Types::String
    attribute :name, Types::String
    attribute :description, Types::String
    attribute :type, Core::Types::ToggleTypes
    attribute :status, Core::Types::ToggleStatuses
    attribute :default_status, Core::Types::ToggleStatuses

    attribute :tags, Types::Array.default([])

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end

  def enable?
    status == ENABLE
  end

  def disable?
    status == DISABLE
  end

  def boolean?
    type == BOOLEAN
  end
end
