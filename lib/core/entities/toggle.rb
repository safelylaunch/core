# frozen_string_literal: true

class Environment
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
    attribute :type, ::Types::ToggleTypes
    attribute :status, ::Types::ToggleStatuses
    attribute :default_status, ::Types::ToggleStatuses

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
