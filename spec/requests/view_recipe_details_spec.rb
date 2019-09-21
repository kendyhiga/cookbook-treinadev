# frozen_string_literal: true

require 'rails_helper'

describe 'View recipe details' do
  it 'returns a json' do
    user = User.create!(email: 'email@email.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = create(:recipe, user: user, recipe_type: recipe_type,
                             cuisine: cuisine)

    get api_v1_recipe_path(1)
    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(json_recipe[:user_id]).to eq recipe.user.id
    expect(json_recipe[:title]).to eq recipe.title
    expect(json_recipe[:difficulty]).to eq recipe.difficulty
    expect(json_recipe[:recipe_type_id]).to eq recipe.recipe_type.id
    expect(json_recipe[:cuisine_id]).to eq recipe.cuisine.id
    expect(json_recipe[:cook_time]).to eq recipe.cook_time
    expect(json_recipe[:ingredients]).to eq recipe.ingredients
    expect(json_recipe[:cook_method]).to eq recipe.cook_method
    expect(response).to have_http_status(200)
  end

  it 'returns status 400 if the recipe doesnt exist' do
    get api_v1_recipe_path(666)
    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(json_recipe[:message]).to eq 'Receita nao encontrada'
    expect(response).to have_http_status(404)
  end
end
