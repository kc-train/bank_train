module BankTrain
  class BusinessOperationsController < BankTrain::ApplicationController
    def index
      if params[:filter].blank?
        @root_operations = BankTrain::BusinessOperation.where(parent_operation: nil)
        return
      end

      @root_operations = BankTrain::BusinessOperation.where(id: params[:filter])
    end

    def new
      @operation = BusinessOperation.new
    end

    def create
      @operation = BusinessOperation.new(bussiness_operations_params)
      if @operation.save
        redirect_to  '/business_operations'
      else
        render "new"
      end
    end

    def edit
      @operation = BusinessOperation.find(params[:id]) 
    end

    def update
      @operation = BusinessOperation.find(params[:id])
      if @operation.update_attributes(bussiness_operations_params)
        redirect_to "/business_operations"
      else
        render "edit"
      end
    end

    def destroy
      @operation = BusinessOperation.find(params[:id])
      @operation.destroy
      redirect_to "/business_operations"
    end

    private

      def bussiness_operations_params
        params.require(:business_operation).permit(:number, :name, :chapter_number, :parent_operation_id,:business_category_ids=>[]) 
      end
  end
end