# frozen_string_literal: true

module Api
  module Presenters
    module V1
      module Check
        class Success
          include Surrealist

          json_schema do
            { key: String, enable: Bool }
          end

          attr_reader :key, :enable

          def initialize(key:, enable:)
            @key = key
            @enable = enable
          end
        end
      end
    end
  end
end
