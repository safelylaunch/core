# frozen_string_literal: true

module Toggles
  module Operations
    class ToggleStatus < Libs::Operation
      include Import[toggle_repo: 'repositories.toggle']

      # TODO: check than account can edit toggle
      def call(id:)
        toggle = yield find_toggle(id)

        Success(toggle_repo.update(id, status: oposit_status(toggle)))
      end

      private

      def find_toggle(id)
        toggle = toggle_repo.find(id)
        toggle ? Success(toggle) : Failure(:not_found)
      end

      def oposit_status(toggle)
        (Core::Types::ToggleStatuses.values - [toggle.status]).first
      end
    end
  end
end
