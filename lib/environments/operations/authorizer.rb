# frozen_string_literal: true

module Environments
  module Operations
    class Authorizer < Libs::Operation
      include Dry::Monads::Do.for(:call)

      include Import[env_repo: 'repositories.environment']

      def call(token:)
        if environment = env_repo.find_for_token(token)
          Success(environment_id: environment.id)
        else
          Failure(ErrorObject.new(:auth_failure, token: token))
        end
      end
    end
  end
end
