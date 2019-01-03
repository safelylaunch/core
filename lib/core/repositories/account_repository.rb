class AccountRepository < Hanami::Repository
  associations do
    has_many :auth_identities
  end
end
