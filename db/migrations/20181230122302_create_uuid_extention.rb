# frozen_string_literal: true

Hanami::Model.migration do
  up do
    execute <<-SQL
      CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
    SQL
  end

  down do
    execute <<-SQL
      DROP EXTENSION IF EXISTS "uuid-ossp";
    SQL
  end
end
