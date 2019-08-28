class Api::V1::RecipesController < Api::V1::ApiController
  def show
    if Recipe.exists?(params[:id])
      @recipe = Recipe.find(params[:id])
      render json: @recipe, status: 200, include: %w[cuisine recipe_type user]
    else
      render json: { status: "Error", code: 404, message: 'Recipe not found' }
    end
  end
end
