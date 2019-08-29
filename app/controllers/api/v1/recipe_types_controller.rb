class Api::V1::RecipeTypesController < Api::V1::ApiController
  def show
    @recipe_type = RecipeType.find(params[:id])
    render json: @recipe_type, status: 200, include: ['recipes']
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Tipo de receita não encontrada', status: 404 }
  end
end
