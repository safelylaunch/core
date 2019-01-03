# frozen_string_literal: true

Fabricator(:account) do
  name 'Anton Test'
  email 'test@md.com'

  role 'user'
end

Fabricator(:admin_account) do
  name 'Anton Test'
  email 'test@md.com'

  role 'admin'
end
