# frozen_string_literal: true

module Web
  module Controllers
    module Environments
      class New
        include Web::Action
        include Import[projects_operation: 'projects.operations.list']

        expose :projects

        # TODO: check that I can show this page for user
        def call(_params)
          @projects = projects_operation.call(account_id: current_account.id).value!
        end
      end
    end
  end
end
