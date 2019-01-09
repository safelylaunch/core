module Web
  module Controllers
    module Projects
      module Members
        class Create
          include Web::Action
          include Dry::Monads::Result::Mixin
          include Import[operation: 'projects.operations.invite_member']

          # TODO: use this endpoint in template
          def call(params)
            result = operation.call(
              project_id: params[:project_id],
              email: params[:member][:email],
              role: params[:member][:role]
            )

            case result
            when Success
              redirect_to routes.project_members_path(params[:project_id])
            when Failure
              redirect_to routes.project_members_path(params[:project_id])
            end
          end
        end
      end
    end
  end
end
