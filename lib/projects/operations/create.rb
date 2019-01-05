# frozen_string_literal: true

module Projects
  module Operations
    class Create < Libs::Operation
      include Dry::Monads::Do.for(:call)
      include Dry::Monads::Try::Mixin

      include Import[project_repo: 'repositories.project']

      def call(name:, account_id:)
        Try(Hanami::Model::UniqueConstraintViolationError) do
          project_repo.create_for_member(account_id, name)
        end.to_result
      end
    end
  end
end
