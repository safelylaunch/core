# frozen_string_literal: true

class EnvironmentRepository < Hanami::Repository
  associations do
    has_many :toggles
  end
end
