module BankTrain
  class Post
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name

    has_and_belongs_to_many :user

    module UserMethods
      extend ActiveSupport::Concern
      included do
        has_and_belongs_to_many :train_posts, class_name: 'BankTrain::Post'
      end
    end
  end
end