# frozen_string_literal: true

module Api
  module Presenters
    module V1
      module Entities
        class Toggle
          include Surrealist

          json_schema do
            {
              key: String,
              type: String,
              enable: Bool,
              default_status: String
            }
          end

          attr_reader :key, :type, :enable, :default_status

          def initialize(toggle)
            @key = toggle.key
            @type = toggle.type
            @enable = toggle.enable?
            @default_status = toggle.default_status
          end
        end
      end
    end
  end
end
