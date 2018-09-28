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
	resources :posts,          only: [:create, :destroy, :show]
	resources :users do
		resources :posts,  only: [:index]
	end
   	resources :posts do
		resources :likes, only: [:create, :destroy, :index]
	end
	resources :posts do
		resources :comments, only: [:create, :destroy, :index]
	end
	# TODO check routes
	resources :users do
    	resources :friend_requests
  	end
	resources :users do
    	resources :friendships
  	end	
  	get '/accept_request/:id', to: 'friend_requests#accept_request', as:'accept'
  	delete '/decline_request/:id',to: 'friend_requests#decline_request', as:'decline'
  	get '/request_friendship/:id', to: 'friend_requests#request_friendship', as:'request'
  	delete '/delete_friendship/:id',to: 'friend_requests#delete_friendship', as:'delete'
  	delete '/delete_sent_friendship/:id',to: 'friend_requests#delete_request', as:'delete_sent'
  	get '/export', to: 'users#export_all', as:'export'

  	resources :joboffers, only: [:create, :destroy, :index, :show]

	resources :joboffers do
		resources :applies, only: [:create, :destroy, :index]
	end
	# TODO check routes
end