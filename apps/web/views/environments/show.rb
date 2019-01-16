# frozen_string_literal: true

module Web
  module Views
    module Environments
      class Show
        include Web::View

        def toggle_status(toggle)
          html.form(action: routes.project_environment_toggle_status_path(params[:project_id], params[:id], toggle.id), method: 'POST') do
            input(type: 'hidden', name: '_method', value: 'PATCH')
            input(type: 'submit', value: toggle.status)
          end
        end
      end
    end
  end
end
