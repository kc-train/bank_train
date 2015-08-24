module BankTrain
  class Engine < ::Rails::Engine
    isolate_namespace BankTrain
    config.to_prepare do
      ApplicationController.helper ::ApplicationHelper
    end
  end
end