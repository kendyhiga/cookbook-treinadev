class UsersController < ApplicationController
  def my_recipes
    @recipes = Recipe.where(user: current_user)
    flash.now[:failure] = 'Você não tem nenhuma receita cadastrada em nosso site'
  end

  def my_lists
    @lists = List.where(user: current_user)
    flash.now[:failure] = 'Você não tem nenhuma lista cadastrada em nosso site'
  end
end
