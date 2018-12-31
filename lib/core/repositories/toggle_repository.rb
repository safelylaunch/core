# frozen_string_literal: true

class ToggleRepository < Hanami::Repository
  associations do
    belongs_to :environment
  end
end
