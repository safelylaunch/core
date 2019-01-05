class ProjectRepository < Hanami::Repository
  associations do
    has_many :environments
    has_many :project_members
    has_many :accounts, through: :project_members
  end
end
