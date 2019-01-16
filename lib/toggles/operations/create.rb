# frozen_string_literal: true

module Toggles
  module Operations
    class Create < Libs::Operation
      include Import[toggle_repo: 'repositories.toggle']

      Dry::Validation.load_extensions(:monads)

      VALIDATOR = Dry::Validation.JSON do
        required(:environment_id).filled(:int?)
        required(:key).filled(:str?)
        required(:name).filled(:str?)

        optional(:description).maybe(:str?)

        optional(:tags).maybe(:str?)

        required(:type).filled(Core::Types::ToggleTypes)
        required(:status).filled(Core::Types::ToggleStatuses)
      end

      def call(payload)
        payload = yield VALIDATOR.call(payload).to_either

        payload[:tags] = payload[:tags].to_s.split(/\s?,\s?/)

        Try(Hanami::Model::UniqueConstraintViolationError) do
          toggle_repo.create(payload)
        end.to_result
      end
    end
  end
end
