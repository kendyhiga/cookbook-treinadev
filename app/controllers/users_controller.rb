class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recipes = Recipe.where(user: @user)
  end

  def my_recipes
    @recipes = Recipe.where(user: current_user)
    flash.now[:failure] = 'Você não tem nenhuma receita cadastrada em nosso site'
  end

  def lists
    @lists = List.where(user: current_user)
    flash.now[:failure] = 'Você não tem nenhuma lista cadastrada em nosso site'
  end

  def search
    @result = []
    if params[:parameter] == ''
      flash.now[:failure] = 'Preencha o campo de pesquisa'
    else
      if params[:parameter]
        @recipes = Recipe.where('title LIKE ?', "%#{params[:parameter]}%")
        @cuisines = Cuisine.where('name LIKE ?', "%#{params[:parameter]}%")
        @recipe_types = RecipeType.where('name LIKE ?', "%#{params[:parameter]}%")
        if @recipes.empty? && params[:parameter]
          flash.now[:failure] = 'Não encontramos nada'
        end
      end
    end
    render :search
  end

end
