module BankTrain
  class PostsController < BankTrain::ApplicationController
    def index
      @posts = BankTrain::Post.all
    end
  end
end