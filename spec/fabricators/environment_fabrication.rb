# frozen_string_literal: true

Fabricator(:environment) do
  name 'test'
  api_key { SecureRandom.uuid }
  color 'ffffff'

  project_id { Fabricate.create(:project).id }
end
