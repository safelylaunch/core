# frozen_string_literal: true

class ProjectRepository < Hanami::Repository
  associations do
    has_many :environments
    has_many :project_members
    has_many :accounts, through: :project_members, as: :members
  end

  def all_for_member(account_id)
    aggregate(:environments)
      .join(:project_members)
      .where(project_members[:account_id].qualified => account_id)
      .map_to(Project).to_a
  end

  def create_for_member(account_id, name)
    transaction do
      project = create(owner_id: account_id, name: name)
      project_member_repo.create(account_id: account_id, project_id: project.id, role: 'admin')
      project
    end
  end

  # HACK: hack for '#create_for_member when user has project with same name' spec
  # TODO: drop this hack
  def project_member_repo
    @project_member_repo ||= ProjectMemberRepository.new
  end

  def remove_member(account_id, project_id)
    project_members.where(account_id: account_id, project_id: project_id).delete
  end
end
