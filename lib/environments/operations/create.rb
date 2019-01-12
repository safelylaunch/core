# frozen_string_literal: true

module Environments
  module Operations
    class Create < ::Libs::Operation
      include Import[
        'environments.libs.api_key_generator',
        env_repo: 'repositories.environment'
      ]

      def call(project_id:, account_id:, name:, color:)
        Try(Hanami::Model::UniqueConstraintViolationError) do
          env_repo.create(project_id: project_id, name: name, color: color, api_key: api_key_generator.call)
        end.to_result
      end
    end
  end
end
