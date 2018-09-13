Rails.application.routes.draw do
  get 'sessions/new'

	root 'static_pages#home'
	get  '/help',    to: 'static_pages#help'
	get  '/about',   to: 'static_pages#about'
	get  '/signup',  to: 'users#new'
	get    '/login',   to: 'sessions#new'
	post   '/login',   to: 'sessions#create'
	delete '/logout',  to: 'sessions#destroy'
	resources :users
	resources :posts,          only: [:create, :destroy]
	resources :users do
		resources :posts,  only: [:index]
	end
   	resources :posts do
		resources :likes, only: [:create, :destroy, :index]
	end
end