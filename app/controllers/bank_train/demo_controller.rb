module BankTrain
  class DemoController < BankTrain::ApplicationController
    layout 'bank_train/demo'

    def filter
      render layout: 'bank_train/application'
    end

    def wizard
      render layout: 'bank_train/application'
    end

    def business_operation
    end

    def business_operation_a
    end

    def screens
    end

    def screens_input
    end

    def inputer_compoents
    end
  end
end