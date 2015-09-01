module BankTrain
  class BusinessCategoriesController < BankTrain::ApplicationController
    def index
      return if params[:format] != "json"

      @categories = BankTrain::BusinessCategory.all

      res = @categories.map do |category|
        oper_hash = category.business_operations.map do |oper|
          {
            :id   => oper.id.to_s,
            :name => oper.name
          }
        end

        {
          :id              => category.id.to_s,
          :parent_id       => category.parent_id.to_s,
          :name            => category.name,
          :children_info   => category.children.count == 0 ? "" : "[#{category.children.count} 项子业务种类]",
          :posts_info      => category.posts.count == 0 ? "" : "[#{category.posts.count} 个对应岗位]",
          :operations      => oper_hash
        }
      end

      render :json => res
    end
  end
end
