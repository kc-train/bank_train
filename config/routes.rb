BankTrain::Engine.routes.draw do
  root 'home#index'

  resources :posts
  resources :levels
  resources :business_categories
  resources :business_operations
end