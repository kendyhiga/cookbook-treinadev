# frozen_string_literal: true

# Recipe Types Controller
class RecipeTypesController < ApplicationController
  def new
    redirect_to root_path unless user_signed_in? && current_user.admin
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.new(recipe_type_params)
    if @recipe_type.save
      redirect_to @recipe_type
    else
      flash.now[:failure] = (t 'unable_to_save_recipe_type')
      render :new
    end
  end

  def show
    @recipe_type = RecipeType.find(params[:id])
    @recipes = Recipe.where(recipe_type: @recipe_type)
    return unless @recipes.empty?

    flash.now[:failure] = (t 'no_recipe_registered_in_recipe_type_yet')
  end

  private

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end
end
