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
end
