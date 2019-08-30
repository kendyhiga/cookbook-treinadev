class Api::V1::UsersController < Api::V1::ApiController
  def reject_recipe
    @recipe = Recipe.find(params[:id])
    @recipe.rejected!
    render json: @recipe, status: 200
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Receita não encontrada'}, status: 404
  end

  def accept_recipe
    @recipe = Recipe.find(params[:id])
    @recipe.accepted!
    render json: @recipe, status: 200
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Receita não encontrada'}, status: 404
  end
end