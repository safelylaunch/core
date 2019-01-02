# frozen_string_literal: true

module Toggles
  module Operations
    class ListOfDefaultValues < Libs::Operation
      include Dry::Monads::Do.for(:call)

      include Import[]

      def call(payload); end
    end
  end
end
