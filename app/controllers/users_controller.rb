# frozen_string_literal: true

# User Controller
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    redirect_to root_path unless user_signed_in?

    @recipes = Recipe.where(user: @user)
  end

  def my_recipes
    @recipes = Recipe.where(user: current_user)
    flash.now[:failure] = (t 'you_have_no_recipes')
  end

  def lists
    @lists = List.where(user: current_user)
    flash.now[:failure] = 'Você não tem nenhuma lista cadastrada em nosso site'
  end

  def reject_recipe
    @recipe = Recipe.find(params[:id])
    @recipe.rejected!
    redirect_to pending_recipes_path
  end

  def accept_recipe
    @recipe = Recipe.find(params[:id])
    @recipe.accepted!
    redirect_to pending_recipes_path
  end
end
