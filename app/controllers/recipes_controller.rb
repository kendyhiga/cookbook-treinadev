class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe_types = RecipeType.all
    if @recipe.save
      redirect_to @recipe 
    else
      flash.now[:failure] = 'Não foi possível salvar a receita'
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @recipe_types = RecipeType.all
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe_types = RecipeType.all
    if  @recipe.update(recipe_params)
      redirect_to @recipe
    else
      flash.now[:failure] = 'Não foi possível salvar a receita'
      render :edit
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine, :difficulty, :cook_time, :ingredients, :cook_method)
  end
end
