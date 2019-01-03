# frozen_string_literal: true

module Api
  module Presenters
    module V1
      module DefaultStatuses
        class Error
          include Surrealist

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

          def initialize(params:)
            @type = :server_error
            @message = 'Server Error'
            @params = params
          end
        end
      end
    end
  end
end
