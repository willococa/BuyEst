Rails.application.routes.draw do
  get '/orders/:id', to: 'orders#show', as: 'order'

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
end
