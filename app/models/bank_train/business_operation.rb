module BankTrain
  class BusinessOperation
    include Mongoid::Document
    include Mongoid::Timestamps

    field :number
    field :name
    field :chapter_number

    has_and_belongs_to_many :business_categories, class_name: 'BankTrain::BusinessCategory'
    belongs_to :parent_operation, class_name: 'BankTrain::BusinessOperation'
    has_many :children_operations, class_name: 'BankTrain::BusinessOperation'

    module UserMethods
      extend ActiveSupport::Concern
      
      # 获取全部操作
      def train_business_operations
        train_business_categories.map {|category|
          category.business_operations
        }.flatten.uniq
      end

      # 根据指定业务类型获取操作
      def train_business_operations_by_category(category)
        if train_business_categories.include? category
          return category.business_operations
        end
        return []
      end
    end
  end
end