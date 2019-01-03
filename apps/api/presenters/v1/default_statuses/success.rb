# frozen_string_literal: true

module Api
  module Presenters
    module V1
      module DefaultStatuses
        class Success
          include Surrealist

          json_schema do
            { toggles: Array }
          end

          attr_reader :toggles

          def initialize(toggles:)
            @toggles = toggles.map { |toggle| Entities::Toggle.new(toggle) }
          end
        end
      end
    end
  end
end
