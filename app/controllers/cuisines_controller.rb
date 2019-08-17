class CuisinesController < ApplicationController
  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(cuisine_params)
    if @cuisine.save
      redirect_to @cuisine
    else
      flash.now[:failure] = 'Não foi possível salvar o tipo de receita'
      render :new
    end
  end

  def show
    @cuisine = Cuisine.find(params[:id])
  end

  private

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end
end
