# frozen_string_literal: true

module Auth
  module Authentication
    def authenticate!
      redirect_to('/login') unless authenticated?
    end

    def authenticated?
      !!current_account.id
    end

    def current_account
      @current_account ||= Account.new(session[:account])
    end
  end
end
