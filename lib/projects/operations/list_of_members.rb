# frozen_string_literal: true

module Projects
  module Operations
    class ListOfMembers < Libs::Operation
      include Import[
        project_member_repo: 'repositories.project_member',
        project_repo: 'repositories.project'
      ]

      def call(project_id:, account_id:)
        yield check_access(account_id, project_id)

        find_project(project_id)
      end

    private

      def check_access(account_id, project_id)
        project_repo.member?(account_id, project_id) ? Success(:member) : Failure(:permission_diened)
      end

      def find_project(project_id)
        project = project_member_repo.all_for_project(project_id)
        project ? Success(project) : Failure(:not_found)
      end
    end
  end
end
