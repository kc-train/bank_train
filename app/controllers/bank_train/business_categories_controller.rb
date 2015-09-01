module BankTrain
  class BusinessCategoriesController < BankTrain::ApplicationController
    def index
      @root_categories = BankTrain::BusinessCategory.where(parent_category: nil)
    end

    def new
      @category = BankTrain::BusinessCategory.new
    end

    def create
      @category = BankTrain::BusinessCategory.new(business_category_params)
      if @category.save
        redirect_to "/business_categories"
      else
        render :new
      end
    end

    def edit
      @category = BankTrain::BusinessCategory.find(params[:id])
    end

    def update
      @category = BankTrain::BusinessCategory.find(params[:id])
      if @category.update(business_category_params)
        redirect_to "/business_categories"
      else
        render :edit
      end
    end

    def destroy
      @category = BankTrain::BusinessCategory.find(params[:id])
      @category.destroy
      redirect_to "/business_categories"
    end

    private
      def business_category_params
        params.require(:business_category).permit(:name, :parent_category_id, :post_ids => [], :business_operation_ids => [])
      end
  end
end