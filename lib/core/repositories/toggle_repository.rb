# frozen_string_literal: true

class ToggleRepository < Hanami::Repository
  associations do
    belongs_to :environment
  end

  def find_by_key_for_env(key, environment_id)
    root.where(key: key, environment_id: environment_id).map_to(Toggle).one
  end

  def all_for(environment_id)
    root.where(environment_id: environment_id).map_to(Toggle).to_a
  end
end
