# frozen_string_literal: true

module Environments
  module Operations
    class Show < ::Libs::Operation
      include Import[env_repo: 'repositories.environment']

      def call(environment_id:, account_id:)
        env = env_repo.find_with_toggles(environment_id)
        env ? Success(env) : Failure(:not_found)
      end
    end
  end
end
