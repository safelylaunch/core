# frozen_string_literal: true

require_relative './oauth/google_callback'

class WebBouncer::OauthContainer # rubocop:disable Style/ClassAndModuleChildren
  register 'oauth.google_callback', Auth::Oauth::GoogleCallback
end
