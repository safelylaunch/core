class ProjectRepository < Hanami::Repository
  associations do
    has_many :environments
    belongs_to :accounts
  end
end
