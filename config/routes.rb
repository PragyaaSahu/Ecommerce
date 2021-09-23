Rails.application.routes.draw do
	
 root to: "home#index"
 # devise_for :users
 devise_for :users, :controllers => {:registrations => "registrations"}

 namespace :admin do
    resources :users
    resources :categories
 end

 namespace :supplier do
 	resources :categories 
    resources :products
 end

 namespace :customer do
 	resources :products
 	resources :carts
 	get '/line_item', to: 'carts#remove_product', as: 'remove_product'
 	post '/line_item', to: 'carts#save_quantity', as: 'save_quantity'
 	resources :orders
 	get '/payment_successful', to: 'orders#payment_successful', as: 'payment_successful'
 	get '/payment_failed', to: 'orders#payment_failed', as: 'payment_failed'
 	resources :reviews
 end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
