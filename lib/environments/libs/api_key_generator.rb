# frozen_string_literal: true

module Environments
  module Libs
    class ApiKeyGenerator
      def call
        SecureRandom.uuid
      end
    end
  end
end
