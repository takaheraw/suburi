Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }

  root 'home#index'

  match '*unmatched_route',
	        via: :all,
	        to: 'application#raise_not_found',
	        format: false
end
