module Web
  module Views
    module Toggles
      class New
        include Web::View

        def form
          form_for :toggle, routes.environment_toggles_path(params[:environment_id]), method: :post do
            text_field :environment_id, type: 'hidden', value: params[:environment_id]

            div do
              label :key
              text_field :key, placeholder: 'new-toggle'
            end

            div do
              label :name
              text_field :name, placeholder: 'Name of your toggle'
            end

            div do
              label :description
              text_area :description, placeholder: 'optional'
            end

            div do
              label :type
              select :type, { 'Boolean' => 'boolean' }
            end

            div do
              label :status
              select :status, { 'Enable' => 'enable', 'Disable' => 'disable' }
            end

            submit 'Create'
          end
        end
      end
    end
  end
end
