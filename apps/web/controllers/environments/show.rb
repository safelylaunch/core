module Web
  module Controllers
    module Environments
      class Show
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[operation: 'environments.operations.show']

        expose :environment

        def call(params)
          result = operation.call(account_id: current_account.id, environment_id: params[:id])

          case result
          when Success
            @environment = result.value!
          when Failure
            redirect_to routes.root_path
          end
        end
      end
    end
  end
end
