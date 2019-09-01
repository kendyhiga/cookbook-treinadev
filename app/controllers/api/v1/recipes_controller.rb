class Api::V1::RecipesController < Api::V1::ApiController

  def index
    case params[:status]
    when nil
      @recipes = Recipe.all 
    when 'accepted'
      @recipes = Recipe.accepted
    when 'rejected'
      @recipes = Recipe.rejected
    when 'pending'
      @recipes = Recipe.pending
    end
    
    if @recipes
      render json: @recipes, status: 200
    else
      render json: { message: 'Status invalido' }, status: 404
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    render json: @recipe, status: 200
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Receita não encontrada'}, status: 404
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      render json: @recipe, status: 201
    else
      render json: { message: 'Não foi possível salvar a receita' }, status: 406
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    render json: @recipe, status: 200
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Receita não encontrada'}, status: 404
  end

  private

  def recipe_params
    params.require(:recipe).permit(:user_id, :title, :recipe_type_id, :cuisine_id,
                                   :difficulty, :cook_time, :ingredients,
                                   :cook_method, :image)
  end
end