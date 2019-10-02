# frozen_string_literal: true

module Api
  module V1
    # Recipe API controller
    class RecipesController < Api::V1::ApiController
      def index
        choose_filter(params[:status])

        if @recipes
          render json: @recipes, status: :ok
        else
          render json: { message: 'Status invalido' }, status: :not_found
        end
      end

      def show
        @recipe = Recipe.find(params[:id])
        render json: @recipe, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { message: 'Receita nao encontrada' }, status: :not_found
      end

      def create
        @recipe = Recipe.new(recipe_params)
        if @recipe.save
          render json: @recipe, except: %i[created_at updated_at],
                 status: :created
        else
          render json: { message: 'Nao foi possivel salvar a receita',
                         errors: @recipe.errors.full_messages },
                 status: :not_acceptable
        end
      end

      def destroy
        @recipe = Recipe.find(params[:id])
        @recipe.destroy
        render json: @recipe, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { message: 'Receita nao encontrada' }, status: :not_found
      end

      private

      def choose_filter(status)
        case status
        when nil
          @recipes = Recipe.all
        when 'accepted'
          @recipes = Recipe.accepted
        when 'rejected'
          @recipes = Recipe.rejected
        when 'pending'
          @recipes = Recipe.pending
        end
      end

      def recipe_params
        params.require(:recipe).permit(:user_id, :title, :recipe_type_id,
                                       :cuisine_id, :difficulty, :cook_time,
                                       :ingredients, :cook_method, :image)
      end
    end
  end
end
