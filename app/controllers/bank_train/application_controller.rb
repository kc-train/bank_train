module BankTrain
  class ApplicationController < ActionController::Base
    layout "bank_train/application"
    helper BankTrainHelper

    if defined? PlayAuth
      helper PlayAuth::SessionsHelper
    end
  end
end