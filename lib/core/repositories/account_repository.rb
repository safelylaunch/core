# frozen_string_literal: true

class AccountRepository < Hanami::Repository
  associations do
    has_many :auth_identities
    has_many :project_members
    has_many :projects, through: :project_members
  end

  def find_by_email(email)
    root.where(email: email).map_to(Account).one
  end
end
