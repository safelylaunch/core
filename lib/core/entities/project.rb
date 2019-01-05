class Account < Hanami::Entity
end

class Project < Hanami::Entity
  attributes do
    attribute :id, Types::Int
    attribute :owner_id, Types::Int
    attribute :owner, Types::Entity(Account)

    attribute :name, Types::String

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
