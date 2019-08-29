require 'rails_helper'

describe 'Register recipe type' do
  it 'succesfully' do
    recipe_type = { recipe_type: { name: 'Massa'} }

    post api_v1_recipe_types_path(recipe_type)
    json_recipe_type = JSON.parse(response.body, symbolize_names: true)

    expect(json_recipe_type[:name]).to eq 'Massa'
    expect(response).to have_http_status(201)
  end

  it 'returns error if the name is missing' do
    recipe_type = { recipe_type: { name: ''} }

    post api_v1_recipe_types_path(recipe_type)
    json_recipe_type = JSON.parse(response.body, symbolize_names: true)

    expect(json_recipe_type[:message]).to eq 'Não foi possível salvar o tipo de receita'
    expect(response).to have_http_status(406)
  end
end