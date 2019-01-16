# frozen_string_literal: true

module Web
  module Controllers
    module Projects
      class Create
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[operation: 'projects.operations.create']

        def call(params)
          result = operation.call(owner_id: current_account.id, name: params[:project][:name])

          case result
          when Success
            redirect_to routes.root_path
          when Failure
            redirect_to routes.root_path
          end
        end
      end
    end
  end
end
