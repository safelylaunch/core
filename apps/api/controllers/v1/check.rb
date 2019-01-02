# frozen_string_literal: true

module Api
  module Controllers
    module V1
      class Check
        include Api::Action
        include Dry::Monads::Result::Mixin
        include Import[operation: 'toggles.operations.check']

        def call(params) # rubocop:disable Metrics/AbcSize
          case result = operation.call(key: params[:key], environment_id: params[:environment_id])
          when Success
            self.body = Presenters::V1::Check::Success.new(result.value!).surrealize
          when Failure
            error = result.failure
            payload = { key: params[:key], environment_id: params[:environment_id] }.merge!(error.payload)

            halt 400, Presenters::V1::Check::Error.new(
              key: params[:key], error_type: error.key, params: payload
            ).surrealize
          end
        end
      end
    end
  end
end
