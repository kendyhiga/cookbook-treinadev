class Api::V1::RecipeTypesController < Api::V1::ApiController
  def show
    @recipe_type = RecipeType.find(params[:id])
    render json: @recipe_type, status: 200, include: ['recipes']
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Tipo de receita não encontrada', status: 404 }
  end

  def create
    @recipe_type = RecipeType.new(recipe_type_params)
    if @recipe_type.save
      render json: @recipe_type, status: 201
    else
      render json: { message: 'Não foi possível salvar o tipo de receita' }, status: 406
    end
  end

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end
end
