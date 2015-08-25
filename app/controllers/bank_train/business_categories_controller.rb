module BankTrain
  class BusinessCategoriesController < BankTrain::ApplicationController
    def index
      @root_categories = BankTrain::BusinessCategory.where(parent_category: nil)
    end
  end
end