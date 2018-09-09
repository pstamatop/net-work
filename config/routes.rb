Rails.application.routes.draw do
  get 'sessions/new'

	root 'static_pages#home'
	get  '/help',    to: 'static_pages#help'
	get  '/about',   to: 'static_pages#about'
	get  '/signup',  to: 'users#new'
	get    '/login',   to: 'sessions#new'
	post   '/login',   to: 'sessions#create'
	delete '/logout',  to: 'sessions#destroy'
	resources :users do
	    member do
	    	get :friends
	    end
	end
	resources :friendships,       only: [:create, :destroy]
	resources :friend_requests
end