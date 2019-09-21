# frozen_string_literal: true

require 'rails_helper'

describe 'Delete recipe' do
  it 'successfully' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe = create(:recipe, user: user, recipe_type: recipe_type,
                             cuisine: cuisine)

    delete api_v1_recipe_path(recipe.id)
    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(Recipe.find_by(id: recipe.id)).to eq nil
    expect(json_recipe[:user_id]).to eq 1
    expect(json_recipe[:title]).to eq recipe.title
    expect(json_recipe[:difficulty]).to eq recipe.difficulty
    expect(json_recipe[:recipe_type_id]).to eq 1
    expect(json_recipe[:cuisine_id]).to eq 1
    expect(json_recipe[:cook_time]).to eq recipe.cook_time
    expect(json_recipe[:ingredients]).to eq recipe.ingredients
    expect(json_recipe[:cook_method]).to eq recipe.cook_method
    expect(response).to have_http_status(200)
  end

  it 'returns status 400 if the recipe doesnt exist' do
    delete api_v1_recipe_path(666)
    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(json_recipe[:message]).to eq 'Receita nao encontrada'
    expect(response).to have_http_status(404)
  end
end
