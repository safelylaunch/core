module Web
  module Controllers
    module Toggles
      class Destroy
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[operation: 'toggles.operations.delete']

        def call(params)
          result = operation.call(id: params[:id])

          case result
          when Success
            redirect_to routes.project_environment_path(params[:project_id], params[:environment_id])
          when Failure
            redirect_to routes.project_environment_path(params[:project_id], params[:environment_id])
          end
        end
      end
    end
  end
end
