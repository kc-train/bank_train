module BankTrain
  class Operation
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name
  end
end