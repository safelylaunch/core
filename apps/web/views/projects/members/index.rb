module Web
  module Views
    module Projects
      module Members
        class Index
          include Web::View

          def add_member_form
            form_for :member, routes.project_members_path(project_id: params[:project_id]), method: :post do
              input(name: '[member]role', type: 'hidden', value: 'member')
              input(name: '[member]email')

              submit 'add'
            end
          end

          def remove_member_button(member_id)
            form_for :project_member, routes.project_member_path(project_id: params[:project_id], id: member_id), method: :delete do
              submit 'Delete'
            end
          end
        end
      end
    end
  end
end
