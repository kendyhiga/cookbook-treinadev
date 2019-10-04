# frozen_string_literal: true

module Api
  module V1
    # Recipe Type API controller
    class RecipeTypesController < Api::V1::ApiController
      def show
        @recipe_type = RecipeType.find(params[:id])
        render json: @recipe_type, status: :ok, include: ['recipes']
      rescue ActiveRecord::RecordNotFound
        render json: { message: 'Tipo de receita não encontrada' },
               status: :not_found
      end

      def create
        @recipe_type = RecipeType.new(recipe_type_params)
        if @recipe_type.save
          render json: @recipe_type, status: :created
        else
          render json: { message: 'Não foi possível salvar o tipo de receita' },
                 status: :not_acceptable
        end
      end

      def recipe_type_params
        params.require(:recipe_type).permit(:name)
      end
    end
  end
end
