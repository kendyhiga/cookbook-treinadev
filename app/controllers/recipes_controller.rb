class RecipesController < ApplicationController
  before_action :find_recipe, only: %i[show edit update]
  before_action :find_references, only: %i[new edit]
  before_action :authenticate_user!, except: %i[index show search]

  def index
    @recipes = Recipe.all
  end

  def show; end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to @recipe
    else
      flash.now[:failure] = 'Não foi possível salvar a receita'
      find_references
      render :new
    end
  end

  def edit; end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      flash.now[:failure] = 'Não foi possível salvar a receita'
      find_references
      render :edit
    end
  end

  def search
    if params[:title] == ''
      flash.now[:failure] = 'Preencha o campo de pesquisa'
    else
      if params[:title]
        @recipes = Recipe.where('title LIKE ?', "%#{params[:title]}%")
        if @recipes.empty? && params[:title]
          flash.now[:failure] = 'Não encontramos nenhuma receita'
        end
      end
    end
    render :search
  end

  def my_recipes
    @recipes = Recipe.where(user: current_user)
    flash.now[:failure] = 'Você não tem nenhuma receita cadastrada em nosso site'
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
