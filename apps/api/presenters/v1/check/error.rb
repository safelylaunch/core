# frozen_string_literal: true

module Api
  module Presenters
    module V1
      module Check
        class Error
          include Surrealist

          ERRORS = {
            not_found: 'Toggle with key "%{key}" not found',
            auth_failure: 'Invalid token "%{token}"'
          }.freeze

          json_schema do
            {
              key: String,
              enable: Bool,
              error: {
                type: Symbol,
                message: String,
                params: Hash
              }
            }
          end

          attr_reader :key, :type, :params

          def initialize(key:, error_type:, params: {})
            @key = key
            @type = error_type
            params.delete(:environment_id)
            @params = params
          end

          def enable
            false
          end

          private

          # Get error message by error type
          def message
            format(ERRORS.fetch(type), **params)
          end
        end
      end
    end
  end
end
