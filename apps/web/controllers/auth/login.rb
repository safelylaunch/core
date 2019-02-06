# frozen_string_literal: true

module Web
  module Controllers
    module Auth
      class Login
        include Web::Action

        def call(params)
          # TODO: check session, if account exist - redirect to dashboard
        end

        private

        def authenticate!
          redirect_to('/') if authenticated?
        end
      end
    end
  end
end
