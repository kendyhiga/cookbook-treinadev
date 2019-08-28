require 'rails_helper'

describe 'View recipe details' do
  it 'returns a json' do
    user = User.create!(email: 'email@email.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create!(user: user, title: 'Bolodecenoura', difficulty: 'Médio',
                            recipe_type: recipe_type, cuisine: cuisine,
                            cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos')

    get "/api/v1/recipes/#{recipe.id}"
    json_recipe = JSON.parse(response.body, symbolize_names: true)

    # expect(json_recipe[:user]).to eq recipe.user
    expect(json_recipe[:title]).to eq recipe.title
    expect(json_recipe[:difficulty]).to eq recipe.difficulty
    # expect(json_recipe[:recipe_type]).to eq recipe.recipe_type
    # expect(json_recipe[:cuisine]).to eq recipe.cuisine
    expect(json_recipe[:cook_time]).to eq recipe.cook_time
    expect(json_recipe[:ingredients]).to eq recipe.ingredients
    expect(json_recipe[:cook_method]).to eq recipe.cook_method
    expect(response).to have_http_status(200)
  end

  it 'returns status 404 if the recipe doesnt exist' do
    get '/api/v1/recipes/666'
    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(json_recipe[:message]).to eq 'Receita não encontrada'
    expect(response).to have_http_status(200)
  end
end
