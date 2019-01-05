# frozen_string_literal: true

module Environments
  module Operations
    class Authorizer < Libs::Operation
      include Dry::Monads::Do.for(:call)

      include Import[env_repo: 'repositories.environment']

      def call(token:)
        environment = env_repo.find_for_token(token)
        environment ? Success(environment_id: environment.id) : Failure(ErrorObject.new(:auth_failure, token: token))
      end
    end
  end
end
