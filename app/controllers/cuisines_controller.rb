# frozen_string_literal: true

# Cuisines Controller
class CuisinesController < ApplicationController
  before_action :authenticate_user!, except: %i[show]

  def index
    @cuisines = Cuisine.all
  end

  def new
    redirect_to root_path unless user_signed_in? && current_user.admin
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(cuisine_params)
    if @cuisine.save
      redirect_to @cuisine
    else
      flash.now[:failure] = (t 'unable_to_save_cuisine')
      render :new
    end
  end

  def show
    @cuisine = Cuisine.find(params[:id])
    @recipes = Recipe.accepted.where(cuisine: @cuisine)
    return unless @recipes.empty?

    flash.now[:failure] = (t 'no_recipe_registered_in_cuisine_yet')
  end

  def edit
    @cuisine = Cuisine.find(params[:id])
  end

  def update
    @cuisine = Cuisine.find(params[:id])
    if @cuisine.update(cuisine_params)
      redirect_to @cuisine
    else
      flash.now[:failure] = (t 'unable_to_save_cuisine')
      render :new
    end
  end

  def destroy
    @cuisine = Cuisine.find(params[:id])
    @cuisine.destroy
    redirect_to cuisines_path
  end

  private

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end
end
