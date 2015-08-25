module BankTrain
  class Level
    include Mongoid::Document
    include Mongoid::Timestamps

    field :number
    field :name

    default_scope ->{order(:id.asc)}

    belongs_to :user
    has_and_belongs_to_many :posts, class_name: 'BankTrain::Post'

    module UserMethods
      extend ActiveSupport::Concern
      included do
        has_one :train_level, class_name: 'BankTrain::Level'
      end
    end
  end
end