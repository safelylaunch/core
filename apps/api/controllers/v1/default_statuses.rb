# frozen_string_literal: true

module Api
  module Controllers
    module V1
      class DefaultStatuses
        include Api::Action
        include Dry::Monads::Result::Mixin
        include Import[
          'environments.operations.authorizer',
          operation: 'toggles.operations.list_of_default_values'
        ]

        def call(params)
          result = authorizer
            .call(token: params[:token])
            .bind { |auth_payload| operation.call(auth_payload) }

          case result
          when Success
            self.body = render_success(toggles: result.value!)
          when Failure
            error_type = result.failure.respond_to?(:key) && result.failure.key

            halt 400, render_failure(error_type: error_type, params: { token: params[:token] })
          end
        end

        private

        def render_success(payload)
          Presenters::V1::DefaultStatuses::Success.new(payload).surrealize
        end

        def render_failure(payload)
          Presenters::V1::DefaultStatuses::Error.new(payload).surrealize
        end
      end
    end
  end
end
