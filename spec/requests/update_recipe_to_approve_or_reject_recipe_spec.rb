require 'rails_helper'

describe 'User can approve or reject recipe' do
  describe 'rejects' do
    it 'successfully' do
      recipe_type = RecipeType.create!(name: 'Sobremesa')
      cuisine = Cuisine.create!(name: 'Brasileira')
      user = User.create!(email: 'admin@email.com', password: '123456')
      recipe = Recipe.create!(title: 'Bolo de fubá', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: cuisine,
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,\
                                  misture com o restante dos ingredientes',
                    user: user)

      post api_v1_reject_recipe_path(recipe.id)
      json_recipe = JSON.parse(response.body, symbolize_names: true)

      expect(json_recipe[:status]).to eq 'rejected'
    end

    it 'an the recipe does not exist' do
      post api_v1_reject_recipe_path(555)
      json_recipe = JSON.parse(response.body, symbolize_names: true)

      expect(json_recipe[:message]).to eq 'Receita não encontrada'
      expect(response).to have_http_status(404)
    end
  end
    
  describe 'rejects' do
    it 'accepts successfully' do
      recipe_type = RecipeType.create!(name: 'Sobremesa')
      cuisine = Cuisine.create!(name: 'Brasileira')
      user = User.create!(email: 'admin@email.com', password: '123456')
      recipe = Recipe.create!(title: 'Bolo de fubá', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: cuisine,
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,\
                                  misture com o restante dos ingredientes',
                    user: user)

      post api_v1_accept_recipe_path(recipe.id)
      json_recipe = JSON.parse(response.body, symbolize_names: true)

      expect(json_recipe[:status]).to eq 'accepted'
    end

    it 'an the recipe does not exist' do
      post api_v1_accept_recipe_path(69)
      json_recipe = JSON.parse(response.body, symbolize_names: true)

      expect(json_recipe[:message]).to eq 'Receita não encontrada'
      expect(response).to have_http_status(404)
    end
  end
end