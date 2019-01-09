# frozen_string_literal: true

module Environments
  module Operations
    class Create < ::Libs::Operation
      include Import[
        'environments.libs.api_key_generator',
        env_repo: 'repositories.environment'
      ]

      def call(project_id:, account_id:, name:, color:)
      end
    end
  end
end
