# frozen_string_literal: true

Fabricator(:project_member) do
  role 'member'

  account_id { Fabricate.create(:account).id }
  project_id { Fabricate.create(:project).id }
end

Fabricator(:project_admin_member) do
  role 'admin'

  account_id { Fabricate.create(:account).id }
  project_id { Fabricate.create(:project).id }
end
