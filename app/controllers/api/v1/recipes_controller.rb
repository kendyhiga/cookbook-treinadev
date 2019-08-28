class Api::V1::RecipesController < Api::V1::ApiController
  def show
    if Recipe.exists?(params[:id])
      @recipe = Recipe.find(params[:id])
      render json: @recipe, status: 200
    else
      render json: { status: "Error", code: 404, message: 'Receita não encontrada' }
    end
  end
end
