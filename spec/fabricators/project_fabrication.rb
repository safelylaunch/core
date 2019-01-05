# frozen_string_literal: true

Fabricator(:project) do
  name 'safelylaunch'

  owner_id { Fabricate.create(:account).id }
end
