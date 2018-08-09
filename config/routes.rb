Rails.application.routes.draw do
  use_doorkeeper

  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout' }

  namespace :api do
    namespace :v1 do
      resources :users, only: [:show]
    end
  end

  root 'home#index'

  match '*unmatched_route',
        via: :all,
        to: 'application#raise_not_found',
        format: false
end
