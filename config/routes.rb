Rails.application.routes.draw do
  resources :product_categories
  resources :products
  devise_for :clients
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "products#index"
end
