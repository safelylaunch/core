# frozen_string_literal: true

module Web
  module Controllers
    module ToggleStatuses
      class Update
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[operation: 'toggles.operations.toggle_status']

        def call(params)
          result = operation.call(id: params[:id])

          case result
          when Success
            redirect_to routes.project_environment_path(params[:project_id], params[:environment_id])
          when Failure
            redirect_to routes.project_environment_path(params[:project_id], params[:environment_id])
          end
        end

        private

        def verify_csrf_token?
          false
        end
      end
    end
  end
end
