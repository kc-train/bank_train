module BankTrain
  class LevelsController < BankTrain::ApplicationController
    def index
      @levels = BankTrain::Level.all
    end

    def new
      @level = Level.new
    end

    def create
      @level = Level.create(level_params)
      if @level.save
        redirect_to "/levels"
      else
        redirect_to "/levels/new"
      end
    end

    def edit
      @level = Level.find(params[:id])
    end

    def update
      @level = Level.find(params[:id])
      if @level.update_attributes(level_params)
        redirect_to "/levels"
      else
        redirect_to "/levels/#{params[:id]}/edit"
      end
    end

    def destroy
      @level = Level.find(params[:id])
      @level.destroy
      redirect_to "/levels"
    end

    private
      def level_params
        params.require(:level).permit(:number, :name, :post_ids => [])
      end
  end
end