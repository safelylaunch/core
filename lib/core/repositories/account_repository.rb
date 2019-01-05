# frozen_string_literal: true

class AccountRepository < Hanami::Repository
  associations do
    has_many :auth_identities
    has_many :project_members
    has_many :projects, through: :project_members
  end
end
