# frozen_string_literal: true

class EnvironmentRepository < Hanami::Repository
  associations do
    has_many :toggles
  end

  def find_for_token(token)
    root.where(api_key: token).map_to(Environment).one
  end
end
