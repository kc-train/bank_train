module BankTrain
  class Engine < ::Rails::Engine
    isolate_namespace BankTrain
    config.to_prepare do
      ApplicationController.helper ::ApplicationHelper

      User.class_eval do
        include BankTrain::Post::UserMethods
        include BankTrain::Level::UserMethods
      end
    end
  end
end