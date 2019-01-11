# frozen_string_literal: true

module Environments
  module Operations
    class Show < ::Libs::Operation
      include Import[env_repo: 'repositories.environment']

      def call(environment_id:, account_id:)
        Success(env_repo.find_with_toggles(environment_id))
      end
    end
  end
end
