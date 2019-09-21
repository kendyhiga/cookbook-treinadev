# frozen_string_literal: true

# User Controller
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recipes = Recipe.where(user: @user)
  end

  def my_recipes
    @recipes = Recipe.where(user: current_user)
    flash.now[:failure] = 'Você não tem nenhuma receita cadastrada em nosso '\
                          'site'
  end

  def lists
    @lists = List.where(user: current_user)
    flash.now[:failure] = 'Você não tem nenhuma lista cadastrada em nosso site'
  end

  def search
    @result = []
    if params[:parameter] == ''
      flash.now[:failure] = 'Preencha o campo de pesquisa'
    elsif params[:parameter]
      search_recipe
    end
    render :search
  end

  def reject_recipe
    @recipe = Recipe.find(params[:id])
    @recipe.rejected!
    redirect_to pending_recipes_path
  end

  def accept_recipe
    @recipe = Recipe.find(params[:id])
    @recipe.accepted!
    redirect_to pending_recipes_path
  end

  private

  def search_recipe
    @recipes = Recipe.where('title LIKE ?', "%#{params[:parameter]}%")
    @cuisines = Cuisine.where('name LIKE ?', "%#{params[:parameter]}%")
    @recipe_types = RecipeType.where('name LIKE ?', "%#{params[:parameter]}%")
    return unless @recipes.empty? && params[:parameter]

    flash.now[:failure] = 'Não encontramos nada'
  end
end
