module Web
  module Controllers
    module Toggles
      class Create
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[operation: 'toggles.operations.create']

        def call(params)
          payload = params[:toggle]
          payload[:environment_id] = params[:environment_id].to_i
          result = operation.call(payload)

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
