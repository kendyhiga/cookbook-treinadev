require 'rails_helper'

describe 'List recipes by recipe type' do
  it 'returns a json' do
    user = User.create!(email: 'email@email.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    other_recipe_type = RecipeType.create!(name: 'Salgado')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create!(user: user, title: 'Bolo de cenoura', difficulty: 'Médio',
                            recipe_type: recipe_type, cuisine: cuisine,
                            cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos')
    Recipe.create!(user: user, title: 'Bolo de laranja', difficulty: 'Médio',
                                  recipe_type: other_recipe_type, cuisine: cuisine,
                                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos')
    other_recipe = Recipe.create!(user: user, title: 'Bolo de limão', difficulty: 'Médio',
                                    recipe_type: recipe_type, cuisine: cuisine,
                                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos')
  
    get "/api/v1/recipe_types/#{recipe_type.id}"
    json_recipe_type = JSON.parse(response.body, symbolize_names: true)

    expect(json_recipe_type[:name]).to eq recipe_type.name
    expect(json_recipe_type[:recipes].size).to eq 2
    expect(json_recipe_type[:recipes][0][:title]).to eq recipe.title
    expect(json_recipe_type[:recipes][1][:title]).to eq other_recipe.title
    expect(response).to have_http_status(200)
  end

  it 'returns status 404 if the recipe doesnt exist' do
    get '/api/v1/recipe_types/13'
    json_recipe_type = JSON.parse(response.body, symbolize_names: true)

    expect(json_recipe_type[:message]).to eq 'Tipo de receita não encontrada'
    expect(response).to have_http_status(200)
  end
end
