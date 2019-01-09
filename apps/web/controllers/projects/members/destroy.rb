module Web
  module Controllers
    module Project
      module Members
        class Destroy
          include Web::Action
          include Dry::Monads::Result::Mixin
          include Import[operation: 'projects.operations.remove_member']

          def call(params)
            result = operation.call(
              project_id: params[:project_id],
              account_id: params[:id]
            )

            case result
            when Success
              redirect_to routes.project_path(params[:project_id])
            when Failure
              redirect_to routes.project_path(params[:project_id])
            end
          end
        end
      end
    end
  end
end
