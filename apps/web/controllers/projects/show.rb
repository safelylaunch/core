# frozen_string_literal: true

module Web
  module Controllers
    module Projects
      class Show
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[
          operation: 'projects.operations.show',
          projects_operation: 'projects.operations.list'
        ]

        expose :project, :projects

        def call(params)
          result = operation.call(account_id: current_account.id, project_id: params[:id])

          case result
          when Success
            @project = result.value!
            @projects = projects_operation.call(account_id: current_account.id).value!
          when Failure
            redirect_to routes.root_path
          end
        end
      end
    end
  end
end
