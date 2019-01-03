# frozen_string_literal: true

module Api
  module Controllers
    module V1
      class DefaultStatuses
        include Api::Action
        include Dry::Monads::Result::Mixin
        include Import[operation: 'toggles.operations.list_of_default_values']

        def call(params)
          case result = operation.call(environment_id: params[:environment_id])
          when Success
            self.body = render_success(toggles: result.value!)
          when Failure
            payload = { environment_id: params[:environment_id] }
            halt 400, render_failure(params: payload)
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
