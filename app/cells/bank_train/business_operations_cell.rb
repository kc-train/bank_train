module BankTrain
  class BusinessOperationsCell < Cell::Rails
    def tree_node(operation)
      @operation = operation
      render
    end
  end
end