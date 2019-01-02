# frozen_string_literal: true

class ToggleRepository < Hanami::Repository
  associations do
    belongs_to :environment
  end

  def find_by_key_for_env(key, environment_id)
    root.where(key: key, environment_id: environment_id).map_to(Toggle).one
  end
end
