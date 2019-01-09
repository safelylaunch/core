# frozen_string_literal: true

root to: 'dashboard#index'

get '/login', to: 'auth#login'

resources :projects, only: %i[new create show]
