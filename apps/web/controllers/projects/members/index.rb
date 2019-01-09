module Web
  module Controllers
    module Projects
      module Members
        class Index
          include Web::Action
          include Dry::Monads::Result::Mixin
          include Import[operation: 'projects.operations.list_of_members']

          expose :members

          def call(params)
            result = operation.call(account_id: current_account.id, project_id: params[:project_id])

            case result
            when Success
              @members = result.value!
            when Failure
              redirect_to routes.project_path(params[:project_id])
            end
          end
        end
      end
    end
  end
end
