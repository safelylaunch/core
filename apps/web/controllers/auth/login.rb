# frozen_string_literal: true

module Web
  module Controllers
    module Auth
      class Login
        include Web::Action

        def call(params)
          # TODO: check session, if account exist - redirect to dashboard
        end
      end
    end
  end
end
