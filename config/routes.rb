Rails.application.routes.draw do
	devise_for :users
  	resources :products do
  		resources :notifications
  		member do
  			put "like", to: "products#upvote"
  		end
  	end
  	root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
