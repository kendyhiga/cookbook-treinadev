# frozen_string_literal: true

# Cuisines Controller
class CuisinesController < ApplicationController
  before_action :authenticate_user!, except: %i[show]

  def new
    redirect_to root_path unless user_signed_in? && current_user.admin
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(cuisine_params)
    if @cuisine.save
      redirect_to @cuisine
    else
      flash.now[:failure] = 'Não foi possível salvar a cozinha'
      render :new
    end
  end

  def show
    @cuisine = Cuisine.find(params[:id])
    @recipes = Recipe.where(cuisine: @cuisine)
    return unless @recipes.empty?

    flash.now[:failure] = 'Nenhuma receita desta cozinha foi cadastrada ainda'
  end

  private

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end
end
