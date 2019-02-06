# frozen_string_literal: true

Hanami::Model.migration do
  change do
    add_column :toggles, :tags, 'text[]'
  end
end
