module BankTrain
  class Level
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name

    belongs_to :user

    module UserMethods
      extend ActiveSupport::Concern
      included do
        has_one :train_level, class_name: 'BankTrain::Level'
      end
    end
  end
end