# frozen_string_literal: true

# Recipes Lists Controller
class RecipeListsController < ApplicationController
  def create
    @list = List.find(params[:recipe_list][:list_id])
    @recipe = Recipe.find(params[:recipe_list][:recipe_id])
    @recipe_list = RecipeList.new(recipe: @recipe, list: @list)
    unless @recipe_list.save
      flash[:alert] = 'Esta receita ja foi adicionado a esta lista'
    end
    redirect_to @recipe
  end

  def destroy
    @list = List.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_list = RecipeList.where(recipe: @recipe, list: @list)
    RecipeList.delete(@recipe_list)
    flash[:alert] = "Receita #{@recipe.title} foi removida da lista"
    redirect_to @list
  end
end
