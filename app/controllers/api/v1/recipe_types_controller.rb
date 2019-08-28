class Api::V1::RecipeTypesController < Api::V1::ApiController
  def show
    if RecipeType.exists?(params[:id])
      @recipe_type = RecipeType.find(params[:id])
      render json: @recipe_type, status: 200, include: [ 'recipes' ]
    else
      render json: { status: "Erro", code: 404, message: 'Tipo de receita não encontrada' }
    end
  end
end
