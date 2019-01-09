module Web
  module Controllers
    module Project
      module Members
        class Destroy
          include Web::Action

          def call(params)
            redirect_to routes.project_path(params[:project_id])
          end
        end
      end
    end
  end
end
