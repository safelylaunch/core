# frozen_string_literal: true

module Toggles
  module Operations
    class Delete < Libs::Operation
      include Import[toggle_repo: 'repositories.toggle']

      # TODO: check than account can edit toggle
      def call(id:)
        Success(toggle_repo.delete(id))
      end
    end
  end
end
