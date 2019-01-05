# frozen_string_literal: true

Fabricator(:environment) do
  name 'test'
  api_key '1234567890'
  color 'ffffff'

  project_id { Fabricate.create(:project).id }
end
