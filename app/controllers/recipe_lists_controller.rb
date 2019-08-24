class RecipeListsController < ApplicationController
  def create
    @list = List.find(params[:recipe_list][:list_id])
    @recipe = Recipe.find(params[:recipe_list][:recipe_id])
    @recipe_list = RecipeList.new(recipe: @recipe, list: @list)
    @recipe_list.save
    redirect_to @recipe
  end

  private

  def recipe_list_params
    params.require(:recipe_list).permit(:recipe, :list)
  end
end
