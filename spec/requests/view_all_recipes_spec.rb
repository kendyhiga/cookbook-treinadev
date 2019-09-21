# frozen_string_literal: true

require 'rails_helper'

describe 'Request shows all recipes' do
  before :each do
    user = create(:user)
    recipe_type = create(:recipe_type, name: 'Bolo')
    cuisine = create(:cuisine)
    create(:recipe, user: user, title: 'Bolo de cenoura', status: 'accepted',
                    recipe_type: recipe_type, cuisine: cuisine)
    create(:recipe, user: user, title: 'Bolo de laranja', status: 'accepted',
                    recipe_type: recipe_type, cuisine: cuisine)
    create(:recipe, user: user, title: 'Bolo de limao', status: 'accepted',
                    recipe_type: recipe_type, cuisine: cuisine)
    create(:recipe, user: user, title: 'Bolo de pessego', status: 'pending',
                    recipe_type: recipe_type, cuisine: cuisine)
    create(:recipe, user: user, title: 'Bolo de maracuja', status: 'pending',
                    recipe_type: recipe_type, cuisine: cuisine)
    create(:recipe, user: user, title: 'Bolo de morango', status: 'rejected',
                    recipe_type: recipe_type, cuisine: cuisine)
    create(:recipe, user: user, title: 'Bolo de abacaxi', status: 'rejected',
                    recipe_type: recipe_type, cuisine: cuisine)
  end

  it 'show every single recipe if no param is sent' do
    get '/api/v1/recipes'
    json_accepted_recipes = JSON.parse(response.body, symbolize_names: true)

    expect(json_accepted_recipes.size).to eq 7
    expect(json_accepted_recipes[0][:title]).to eq 'Bolo de cenoura'
    expect(json_accepted_recipes[1][:title]).to eq 'Bolo de laranja'
    expect(json_accepted_recipes[2][:title]).to eq 'Bolo de limao'
    expect(json_accepted_recipes[3][:title]).to eq 'Bolo de pessego'
    expect(json_accepted_recipes[4][:title]).to eq 'Bolo de maracuja'
    expect(json_accepted_recipes[5][:title]).to eq 'Bolo de morango'
    expect(json_accepted_recipes[6][:title]).to eq 'Bolo de abacaxi'
    expect(response).to have_http_status(200)
  end

  it 'filtered by accepted ones' do
    get '/api/v1/recipes?status=accepted'
    json_accepted_recipes = JSON.parse(response.body, symbolize_names: true)

    expect(json_accepted_recipes.size).to eq 3
    expect(json_accepted_recipes[0][:title]).to eq 'Bolo de cenoura'
    expect(json_accepted_recipes[1][:title]).to eq 'Bolo de laranja'
    expect(json_accepted_recipes[2][:title]).to eq 'Bolo de limao'
    expect(json_accepted_recipes).not_to include 'Bolo de pessego'
    expect(json_accepted_recipes).not_to include 'Bolo de maracuja'
    expect(json_accepted_recipes).not_to include 'Bolo de morango'
    expect(json_accepted_recipes).not_to include 'Bolo de abacaxi'
    expect(response).to have_http_status(200)
  end

  it 'filtered by rejected ones' do
    get '/api/v1/recipes?status=rejected'
    json_accepted_recipes = JSON.parse(response.body, symbolize_names: true)

    expect(json_accepted_recipes.size).to eq 2
    expect(json_accepted_recipes[0][:title]).to eq 'Bolo de morango'
    expect(json_accepted_recipes[1][:title]).to eq 'Bolo de abacaxi'
    expect(json_accepted_recipes).not_to include 'Bolo de cenoura'
    expect(json_accepted_recipes).not_to include 'Bolo de laranja'
    expect(json_accepted_recipes).not_to include 'Bolo de limao'
    expect(json_accepted_recipes).not_to include 'Bolo de pessego'
    expect(json_accepted_recipes).not_to include 'Bolo de maracuja'
    expect(response).to have_http_status(200)
  end

  it 'filtered by pending ones' do
    get '/api/v1/recipes?status=pending'
    json_accepted_recipes = JSON.parse(response.body, symbolize_names: true)

    expect(json_accepted_recipes.size).to eq 2
    expect(json_accepted_recipes[0][:title]).to eq 'Bolo de pessego'
    expect(json_accepted_recipes[1][:title]).to eq 'Bolo de maracuja'
    expect(json_accepted_recipes).not_to include 'Bolo de cenoura'
    expect(json_accepted_recipes).not_to include 'Bolo de laranja'
    expect(json_accepted_recipes).not_to include 'Bolo de limao'
    expect(json_accepted_recipes).not_to include 'Bolo de morango'
    expect(json_accepted_recipes).not_to include 'Bolo de abacaxi'
    expect(response).to have_http_status(200)
  end

  it 'returns status 404 if status is invalid' do
    get '/api/v1/recipes?status=qualquer_coisa_invalida'
    json_recipes = JSON.parse(response.body, symbolize_names: true)

    expect(json_recipes[:message]).to eq 'Status invalido'
    expect(response).to have_http_status(404)
  end
end
