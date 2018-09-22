require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web, at: 'sidekiq', as: :sidekiq
  end

  use_doorkeeper

  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout' }

  namespace :setting do
    resource :profile, only: [:show, :update]
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: [:show]
    end
  end

  namespace :admin do
    root 'home#index'
  end

  root 'home#index'

  match '*unmatched_route',
        via: :all,
        to: 'application#raise_not_found',
        format: false
end
