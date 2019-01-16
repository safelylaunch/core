# frozen_string_literal: true

module Web
  module Views
    module Environments
      class New
        include Web::View

        def form
          form_for :environment, routes.project_environments_path(params[:project_id]), method: :post do
            text_field :project_id, type: 'hidden', value: params[:project_id]

            div do
              label :name
              text_field :name, placeholder: 'Name of your environment'
            end

            div do
              label :color
              text_field :color
            end

            submit 'Create'
          end
        end
      end
    end
  end
end
