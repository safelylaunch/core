# frozen_string_literal: true

module Api
  module Presenters
    module V1
      module DefaultStatuses
        class Error
          include Surrealist

          SERVER_ERROR = :server_error

          ERRORS = {
            server_error: 'Server Error',
            auth_failure: 'Invalid token "%{token}"'
          }.freeze

          json_schema do
            {
              error: {
                type: Symbol,
                message: String,
                params: Hash
              }
            }
          end

          attr_reader :params, :type, :message

          def initialize(error_type:, params:)
            @type = error_type || SERVER_ERROR
            params.delete(:environment_id)
            @params = params
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
