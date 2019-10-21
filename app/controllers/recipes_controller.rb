# frozen_string_literal: true

# Recipes Controller
class RecipesController < ApplicationController
  before_action :find_recipe, only: %i[show edit update]
  before_action :find_references, only: %i[new edit]
  before_action :authenticate_user!, except: %i[index show all]

  def index
    @recipes = Recipe.accepted.last(6).reverse
  end

  def show
    if @recipe.accepted? || @recipe.user == current_user ||
       (user_signed_in? && current_user.admin?)

      @user = current_user
      @lists = List.where(user: current_user)
      @recipe_list = RecipeList.new
    else
      redirect_to root_path
    end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      flash.now[:failure] = 'Não foi possível salvar a receita'
      find_references
      render :new
    end
  end

  def edit
    redirect_to root_path unless current_user.can_edit?(@recipe)
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      flash.now[:failure] = 'Não foi possível salvar a receita'
      find_references
      render :edit
    end
  end

  def all
    @recipes = Recipe.accepted
  end

  def pending_line
    @recipes = Recipe.pending
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                   :difficulty, :cook_time, :ingredients,
                                   :cook_method, :image_url)
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def find_references
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end
end
