BankTrain::Engine.routes.draw do
  root 'home#index'

  resources :posts
  resources :levels
  resources :business_categories
  resources :business_operations

  get '/demo/business_operation', to: 'demo#business_operation'
  get '/demo/screens', to: 'demo#screens'
end