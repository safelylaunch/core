# frozen_string_literal: true

namespace 'v1' do
  get '/check', to: 'v1#check'
  get '/default_statuses', to: 'v1#default_statuses'
end
