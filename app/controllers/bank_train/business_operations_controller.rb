module BankTrain
  class BusinessOperationsController < BankTrain::ApplicationController
    def index
      if params[:filter].blank?
        @root_operations = BankTrain::BusinessOperation.where(parent_operation: nil)
        return
      end

      @root_operations = BankTrain::BusinessOperation.where(id: params[:filter])
    end
  end
end