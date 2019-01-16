# frozen_string_literal: true

module Web
  module Controllers
    module Toggles
      class New
        include Web::Action
        include Import[projects_operation: 'projects.operations.list']

        expose :projects

        def call(_params)
          @projects = projects_operation.call(account_id: current_account.id).value!
        end
      end
    end
  end
end
