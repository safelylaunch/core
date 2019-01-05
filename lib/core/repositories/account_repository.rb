class AccountRepository < Hanami::Repository
  associations do
    has_many :auth_identities
    has_many :projects
  end
end
