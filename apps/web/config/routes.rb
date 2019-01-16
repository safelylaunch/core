# frozen_string_literal: true

root to: 'dashboard#index'

get '/login', to: 'auth#login'

resources :projects, only: %i[new create show] do
  resources :members, only: %i[index create destroy]

  resources :environments, only: %i[new create show], controller: 'environments' do
    resources :toggle_statuses, only: %i[update], controller: 'toggle_statuses'
    resources :toggles, only: %i[new create destroy], controller: 'toggles'
  end
end
