Rails.application.routes.draw do
	root 'dealership#index'

	resources :dealerships do
		resources :cars
	end
end
