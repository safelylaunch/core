# frozen_string_literal: true

module Projects
  module Operations
    class List < Libs::Operation
      include Import[project_repo: 'repositories.project']

      def call(account_id:)
        Success(project_repo.all_for_member(account_id)) # => Success(bool)
      end
    end
  end
end
