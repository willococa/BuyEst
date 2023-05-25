require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  get '/orders/:id', to: 'orders#show', as: 'order'
  get '/checkouts', to: 'checkouts#new', as: 'new_checkout'
  post '/checkouts', to: 'checkouts#create', as: 'create_checkout'
  resources :checkouts, only: [:new, :create]
  resources :product_categories
  resources :products do
    post 'add_to_order', on: :member
    delete 'remove_from_order', on: :member
  end
  devise_for :clients, controllers: {
    sessions: 'clients/sessions'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "products#index"

  mount Sidekiq::Web => '/sidekiq'
end
