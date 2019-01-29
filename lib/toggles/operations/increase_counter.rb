# frozen_string_literal: true

module Toggles
  module Operations
    class IncreaseCounter < Libs::Operation
      include Import[toggle_counter_repo: 'repositories.toggle_counter']

      # TODO: check than account can edit toggle
      def call(toggle_id:)
        Success(toggle_counter_repo.increase_today_counter(toggle_id))
      end
    end
  end
end
