require 'rails_helper'

describe 'Register recipe' do
  it 'succesfully' do
    User.create!(email: 'email@email.com', password: '123456')
    RecipeType.create!(name: 'Sobremesa')
    Cuisine.create(name: 'Brasileira')
    recipe = { recipe: { user_id: '1', title: 'Bolo de cenoura', difficulty: 'Médio',
                         recipe_type_id: 1, cuisine_id: 1,
                         cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                         cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos' } }

    post api_v1_recipes_path(recipe)
    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(json_recipe[:user_id]).to eq 1
    expect(json_recipe[:title]).to eq 'Bolo de cenoura'
    expect(json_recipe[:difficulty]).to eq 'Médio'
    expect(json_recipe[:recipe_type_id]).to eq 1
    expect(json_recipe[:cuisine_id]).to eq 1
    expect(json_recipe[:cook_time]).to eq 50
    expect(json_recipe[:ingredients]).to eq 'Farinha, açucar, cenoura'
    expect(json_recipe[:cook_method]).to eq 'Cozinhe a cenoura, corte em pedaços pequenos'
    expect(response).to have_http_status(201)
  end

  it 'returns error if the title is missing' do
    User.create!(email: 'email@email.com', password: '123456')
    RecipeType.create!(name: 'Sobremesa')
    Cuisine.create(name: 'Brasileira')
    recipe = { recipe: { user_id: '1', title: '', difficulty: 'Médio',
                         recipe_type_id: 1, cuisine_id: 1,
                         cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                         cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos' } }

    post api_v1_recipes_path(recipe)
    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(json_recipe[:message]).to eq 'Não foi possível salvar a receita'
    expect(response).to have_http_status(406)
  end
end