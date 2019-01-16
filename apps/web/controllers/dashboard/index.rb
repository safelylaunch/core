# frozen_string_literal: true

module Web
  module Controllers
    module Dashboard
      class Index
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[operation: 'projects.operations.list']

        expose :projects

        def call(_params)
          case result = operation.call(account_id: current_account.id)
          when Success
            @projects = result.value!
          end
        end
      end
    end
  end
end
