class ProjectMemberRepository < Hanami::Repository
  associations do
    belongs_to :account
    belongs_to :project
  end
end
