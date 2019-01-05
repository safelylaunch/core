# frozen_string_literal: true

module Api
  module Controllers
    module V1
      class Check
        include Api::Action
        include Dry::Monads::Result::Mixin
        include Import[
          'environments.operations.authorizer',
          operation: 'toggles.operations.check'
        ]

        def call(params) # rubocop:disable Metrics/AbcSize
          result = authorizer.call(token: params[:token]).bind do |auth_payload|
            operation.call(key: params[:key], environment_id: auth_payload[:environment_id])
          end

          case result
          when Success
            self.body = render_success(result.value!)
          when Failure
            payload = { key: params[:key], token: params[:token] }.merge!(result.failure.payload)

            halt 400, render_failure(key: params[:key], error_type: result.failure.key, params: payload)
          end
        end

        private

        def render_success(payload)
          Presenters::V1::Check::Success.new(payload).surrealize
        end

        def render_failure(payload)
          Presenters::V1::Check::Error.new(payload).surrealize
        end
      end
    end
  end
end
