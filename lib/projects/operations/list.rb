# frozen_string_literal: true

module Projects
  module Operations
    class List < Libs::Operation
      include Dry::Monads::Do.for(:call)

      include Import[project_repo: 'repositories.project']

      def call(account_id:)
        Success([])
      end
    end
  end
end
