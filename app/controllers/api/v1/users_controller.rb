# frozen_string_literal: true

module Api
  module V1
    # User API controller
    class UsersController < Api::V1::ApiController
      def reject_recipe
        @recipe = Recipe.find(params[:id])
        @recipe.rejected!
        render json: @recipe, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { message: 'Receita não encontrada' }, status: :not_found
      end

      def accept_recipe
        @recipe = Recipe.find(params[:id])
        @recipe.accepted!
        render json: @recipe, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { message: 'Receita não encontrada' }, status: :not_found
      end
    end
  end
end
