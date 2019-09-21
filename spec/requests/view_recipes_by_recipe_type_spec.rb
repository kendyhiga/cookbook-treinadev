# frozen_string_literal: true

require 'rails_helper'

describe 'List recipes by recipe type' do
  it 'returns a json' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    other_recipe_type = create(:recipe_type, name: 'Salgado')
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe = create(:recipe, user: user, recipe_type: recipe_type,
                             cuisine: cuisine)
    other_recipe = create(:recipe, user: user, title: 'Bolo de limão',
                                   recipe_type: recipe_type, cuisine: cuisine)
    create(:recipe, user: user, title: 'Bolo de laranja',
                    recipe_type: other_recipe_type, cuisine: cuisine)

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
