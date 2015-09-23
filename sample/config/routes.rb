Rails.application.routes.draw do
  mount BankTrain::Engine => '/', :as => 'bank_train'
  # mount PlayAuth::Engine => '/auth', :as => :auth
end
