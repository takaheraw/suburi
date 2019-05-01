require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: 'sidekiq', as: :sidekiq

  use_doorkeeper

  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }

  namespace :api do
    namespace :v1 do
      resources :users, only: [:show] do
      end
    end
  end

  root 'home#index'

  match '*unmatched_route',
        via: :all,
        to: 'application#raise_not_found',
        format: false
end
