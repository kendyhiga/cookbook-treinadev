# frozen_string_literal: true

# This controller will be used to manage the common content
class PagesController < ApplicationController
  def about; end

  def api_doc
    @api_doc_custom_view = true
  end

  def search
    @result = []
    if params[:parameter] == ''
      flash.now[:failure] = 'Preencha o campo de pesquisa'
    elsif params[:parameter]
      search_recipe(params[:parameter].downcase)
    end
    render :search
  end

  private

  def search_recipe(parameter)
    @recipes = Recipe.where('LOWER(title) LIKE ?', "%#{parameter}%")
    @cuisines = Cuisine.where('LOWER(name) LIKE ?', "%#{parameter}%")
    @recipe_types = RecipeType.where('LOWER(name) LIKE ?', "%#{parameter}%")
    return unless @recipes.empty? && parameter

    flash.now[:failure] = 'Não encontramos nada'
  end
end
