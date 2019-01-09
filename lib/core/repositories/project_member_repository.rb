# frozen_string_literal: true

class ProjectMemberRepository < Hanami::Repository
  associations do
    belongs_to :account
    belongs_to :project
  end

  def all_for_project(project_id)
    aggregate(:account).where(project_id: project_id).map_to(ProjectMember).to_a
  end
end
