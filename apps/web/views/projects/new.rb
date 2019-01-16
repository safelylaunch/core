# frozen_string_literal: true

module Web
  module Views
    module Projects
      class New
        include Web::View

        def form
          form_for :project, routes.projects_path, method: :post do
            text_field :owner_id, type: 'hidden', value: current_account.id

            div do
              label :name
              text_field :name, placeholder: 'Name of your project'
            end

            submit 'Create'
          end
        end
      end
    end
  end
end
