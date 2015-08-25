module BankTrain
  class BusinessCategoriesCell < Cell::Rails
    helper :application

    def tree_node(category, view)
      @category = category
      @view = view
      render
    end
  end
end