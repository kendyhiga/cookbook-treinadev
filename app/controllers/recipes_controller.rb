class RecipesController < ApplicationController
  before_action :find_recipe, only: %i[show edit update]
  before_action :find_references, only: %i[new create edit update]
  def index
    @recipes = Recipe.all
  end

  def show; end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      flash.now[:failure] = 'Não foi possível salvar a receita'
      render :new
    end
  end

  def edit; end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      flash.now[:failure] = 'Não foi possível salvar a receita'
      render :edit
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                   :difficulty, :cook_time, :ingredients,
                                   :cook_method)
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def find_references
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end
end
