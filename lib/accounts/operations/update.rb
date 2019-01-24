# frozen_string_literal: true

module Accounts
  module Operations
    class Update < Libs::Operation
      include Import[
        account_repo: 'repositories.account'
      ]

      def call(account_id:, payload:)
        return Failure(:invalid_account) unless account_id.to_i == account_id

        Try(Hanami::Model::UniqueConstraintViolationError) do
          account_repo.update(account_id, payload)
        end.to_result
      end
    end
  end
end
