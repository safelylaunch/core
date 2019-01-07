# frozen_string_literal: true

require_relative './../../types'

module Projects
  module Operations
    class InviteMember < Libs::Operation
      include Import[
        account_repo: 'repositories.account',
        project_member_repo: 'repositories.project_member'
      ]

      def call(project_id:, email:, role:)
        role = yield validate_role(role)
        account = yield find_account(email)

        Success(project_member_repo.create(account_id: account.id, project_id: project_id, role: role))
      end

    private

      def find_account(email)
        account = account_repo.find_by_email(email)
        account ? Success(account) : Failure(:account_not_found)
      end

      def validate_role(role)
        Try(Dry::Types::ConstraintError) do
          Core::Types::ProjectMemberRoles[role]
        end.to_result.or(Failure(:invalid_role))
      end
    end
  end
end
