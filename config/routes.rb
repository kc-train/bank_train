BankTrain::Engine.routes.draw do
  root 'home#index'

  resources :posts
  resources :levels
  resources :business_categories
  resources :business_operations

  get '/manage', to: 'home#manage'
  get '/demo', to: 'home#demo'
  get '/demo/filter', to: 'demo#filter'

  get '/demo/business_operation', to: 'demo#business_operation'
  get '/demo/business_operation_a', to: 'demo#business_operation_a'
  get '/demo/wizard', to: 'demo#wizard'

  get '/demo/screens', to: 'demo#screens'
  get '/demo/screens_input', to: 'demo#screens_input'
  get '/demo/inputer_compoents', to: 'demo#inputer_compoents'

  get '/demo/yaml_sample', to: 'demo#yaml_sample'
end