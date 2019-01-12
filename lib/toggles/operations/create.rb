# frozen_string_literal: true

module Toggles
  module Operations
    class Create < Libs::Operation
      include Import[toggle_repo: 'repositories.toggle']

      def call(key:, environment_id:)
      end
    end
  end
end
