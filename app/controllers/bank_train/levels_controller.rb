module BankTrain
  class LevelsController < BankTrain::ApplicationController
    def index
      @levels = BankTrain::Level.all
    end
  end
end