# frozen_string_literal: true

module Auth
  module Authentication
    def authenticate!
      redirect_to('/') unless authenticated?
    end

    def authenticated?
      !!current_account.id
    end

    def current_account
      @current_account ||= Account.new(id: 1)
    end
  end
end
