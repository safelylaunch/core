module Web
  module Controllers
    module Environments
      class Create
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[operation: 'environments.operations.create']

        def call(params)
          result = operation.call(account_id: current_account.id, **params[:environment])

          case result
          when Success
            redirect_to routes.project_path(params[:environment][:project_id])
          when Failure
            redirect_to routes.project_path(params[:environment][:project_id])
          end
        end
      end
    end
  end
end
