module BankTrain
  class BusinessOperationsController < BankTrain::ApplicationController
    def index
      return if params[:format] != "json"

      if params[:filter].blank?
        @operations = BankTrain::BusinessOperation.all
      else
        @operations = BankTrain::BusinessOperation.where(id: params[:filter]).first.descendants_and_self
      end
      render :json => @operations.map(&:to_hash)
    end

  end
end
