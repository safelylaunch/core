# frozen_string_literal: true

require_relative './../../types'

module Projects
  module Operations
    class InviteMember < Libs::Operation
      include Dry::Monads::Do.for(:call)
      include Dry::Monads::Try::Mixin

      include Import[project_member_repo: 'repositories.project_member']

      def call(project_id:, account_id:, role:)
        role = yield validate_role(role)
        Success(project_member_repo.create(account_id: account_id, project_id: project_id, role: role))
      end

    private

      def validate_role(role)
        Try(Dry::Types::ConstraintError) do
          Core::Types::ProjectMemberRoles[role]
        end.to_result.or(Failure(:invalid_role))
      end
    end
  end
end
