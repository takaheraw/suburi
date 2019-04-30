Rails.application.routes.draw do
  root 'home#index'

  match '*unmatched_route',
	        via: :all,
	        to: 'application#raise_not_found',
	        format: false
end
