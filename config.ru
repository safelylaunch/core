# frozen_string_literal: true

require './config/environment'
require 'web_bouncer'
require 'web_bouncer/oauth_middleware'
require './lib/auth/oauth_container'

use Rack::Session::Cookie, secret: ENV['WEB_SESSIONS_SECRET']

use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
end

use WebBouncer['middleware.oauth'], model: :account, login_redirect: '/'

run Hanami.app
