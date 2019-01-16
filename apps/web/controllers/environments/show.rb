# frozen_string_literal: true

module Web
  module Controllers
    module Environments
      class Show
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[
          operation: 'environments.operations.show',
          projects_operation: 'projects.operations.list'
        ]

        expose :projects, :environment

        def call(params)
          result = operation.call(account_id: current_account.id, environment_id: params[:id])

          case result
          when Success
            @projects = projects_operation.call(account_id: current_account.id).value!
            @environment = result.value!
          when Failure
            redirect_to routes.root_path
          end
        end
      end
    end
  end
end
