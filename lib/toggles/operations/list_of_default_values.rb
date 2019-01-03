# frozen_string_literal: true

module Toggles
  module Operations
    class ListOfDefaultValues < Libs::Operation
      include Dry::Monads::Do.for(:call)
      include Dry::Monads::Try::Mixin

      include Import[toggle_repo: 'repositories.toggle']

      def call(environment_id:)
        Try(Sequel::DatabaseError) { toggle_repo.all_for(environment_id) }.to_result
      end
    end
  end
end
