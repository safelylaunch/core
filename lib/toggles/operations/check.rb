# frozen_string_literal: true

module Toggles
  module Operations
    class Check < Libs::Operation
      include Dry::Monads::Do.for(:call)

      include Import[toggle_repo: 'repositories.toggle']

      def call(key:, environment_id:)
        toggle = yield find(key, environment_id)
        Success(key: key, enable: toggle.enable?)
      end

      private

      def find(key, environment_id)
        toggle = toggle_repo.find_by_key_for_env(key, environment_id)
        toggle ? Success(toggle) : Failure(ErrorObject.new(:not_found, key: key, environment_id: environment_id))
      end
    end
  end
end
