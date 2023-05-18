Rails.application.routes.draw do
  resources :orders
  resources :product_categories
  resources :products do
    post 'add_to_order', on: :member
    delete 'remove_from_order', on: :member
  end
  devise_for :clients
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "products#index"
end
