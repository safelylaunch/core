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
            self.body = render_success(result.value!)
          when Failure
            error = result.failure
            payload = { key: params[:key], environment_id: params[:environment_id] }.merge!(error.payload)

            halt 400, render_failure(key: params[:key], error_type: error.key, params: payload)
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
