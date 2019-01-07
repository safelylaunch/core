# frozen_string_literal: true

module Projects
  module Operations
    class RemoveMember < Libs::Operation
      include Import[project_repo: 'repositories.project']

      # TODO: check that member can remove admin
      def call(project_id:, account_id:)
        Success(project_repo.remove_member(account_id, project_id))
      end
    end
  end
end
