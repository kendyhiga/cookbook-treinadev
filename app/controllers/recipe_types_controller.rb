class RecipeTypesController < ApplicationController
  before_action :authenticate_user!, except: [new]

  def new
    is_admin?
    @recipe_type = RecipeType.new
  end

  def create
    is_admin?
    @recipe_type = RecipeType.new(recipe_type_params)
    if @recipe_type.save
      redirect_to @recipe_type
    else
      flash.now[:failure] = 'Não foi possível salvar o tipo de receita'
      render :new
    end
  end

  def show
    @recipe_type = RecipeType.find(params[:id])
    @recipes = Recipe.where(recipe_type: @recipe_type)
  end

  private

  def is_admin?
    redirect_to root_path unless user_signed_in? && current_user.role == 'admin'
  end

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end
end
