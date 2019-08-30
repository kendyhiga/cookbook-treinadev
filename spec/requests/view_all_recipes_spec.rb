require 'rails_helper'

describe 'Request shows all recipes' do
  it 'show every single recipe if no param is sent' do
    user = User.create!(email: 'email@email.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create!(user: user, title: 'Bolo de cenoura', difficulty: 'Médio',
                            recipe_type: recipe_type, cuisine: cuisine,
                            cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                            status: 'accepted')
    Recipe.create!(user: user, title: 'Bolo de laranja', difficulty: 'Médio',
                                    recipe_type: recipe_type, cuisine: cuisine,
                                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                                    status: 'accepted')
    Recipe.create!(user: user, title: 'Bolo de limão', difficulty: 'Médio',
                                  recipe_type: recipe_type, cuisine: cuisine,
                                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                                  status: 'accepted')
    Recipe.create!(user: user, title: 'Bolo de pessego', difficulty: 'Médio',
                   recipe_type: recipe_type, cuisine: cuisine,
                   cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                   status: 'pending')
    Recipe.create!(user: user, title: 'Bolo de morango', difficulty: 'Médio',
                   recipe_type: recipe_type, cuisine: cuisine,
                   cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                   status: 'rejected')
  
    get "/api/v1/recipes"
    json_accepted_recipes = JSON.parse(response.body, symbolize_names: true)

    expect(json_accepted_recipes.size).to eq 5
    expect(json_accepted_recipes[0][:title]).to eq 'Bolo de cenoura'
    expect(json_accepted_recipes[1][:title]).to eq 'Bolo de laranja'
    expect(json_accepted_recipes[2][:title]).to eq 'Bolo de limão'
    expect(json_accepted_recipes[3][:title]).to eq 'Bolo de pessego'
    expect(json_accepted_recipes[4][:title]).to eq 'Bolo de morango'
    expect(response).to have_http_status(200)
  end

  it 'filtered by accepted ones' do
    user = User.create!(email: 'email@email.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create!(user: user, title: 'Bolo de cenoura', difficulty: 'Médio',
                            recipe_type: recipe_type, cuisine: cuisine,
                            cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                            status: 'accepted')
    another_recipe = Recipe.create!(user: user, title: 'Bolo de laranja', difficulty: 'Médio',
                                    recipe_type: recipe_type, cuisine: cuisine,
                                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                                    status: 'accepted')
    other_recipe = Recipe.create!(user: user, title: 'Bolo de limão', difficulty: 'Médio',
                                  recipe_type: recipe_type, cuisine: cuisine,
                                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                                  status: 'accepted')
    Recipe.create!(user: user, title: 'Bolo de pessego', difficulty: 'Médio',
                   recipe_type: recipe_type, cuisine: cuisine,
                   cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                   status: 'pending')
    Recipe.create!(user: user, title: 'Bolo de morango', difficulty: 'Médio',
                   recipe_type: recipe_type, cuisine: cuisine,
                   cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                   status: 'rejected')
  
    get "/api/v1/recipes?status=accepted"
    json_accepted_recipes = JSON.parse(response.body, symbolize_names: true)

    expect(json_accepted_recipes.size).to eq 3
    expect(json_accepted_recipes[0][:title]).to eq recipe.title
    expect(json_accepted_recipes[1][:title]).to eq another_recipe.title
    expect(json_accepted_recipes[2][:title]).to eq other_recipe.title
    expect(json_accepted_recipes).not_to include 'Bolo de pessego'
    expect(json_accepted_recipes).not_to include 'Bolo de morango'
    expect(response).to have_http_status(200)
  end

  it 'filtered by rejected ones' do
    user = User.create!(email: 'email@email.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create!(user: user, title: 'Bolo de cenoura', difficulty: 'Médio',
                   recipe_type: recipe_type, cuisine: cuisine,
                   cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                   status: 'accepted')
    Recipe.create!(user: user, title: 'Bolo de laranja', difficulty: 'Médio',
                   recipe_type: recipe_type, cuisine: cuisine,
                   cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                   status: 'accepted')
    Recipe.create!(user: user, title: 'Bolo de limão', difficulty: 'Médio',
                   recipe_type: recipe_type, cuisine: cuisine,
                   cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                   status: 'rejected')
    Recipe.create!(user: user, title: 'Bolo de pessego', difficulty: 'Médio',
                   recipe_type: recipe_type, cuisine: cuisine,
                   cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                   status: 'pending')
    Recipe.create!(user: user, title: 'Bolo de morango', difficulty: 'Médio',
                   recipe_type: recipe_type, cuisine: cuisine,
                   cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                   status: 'rejected')
  
    get "/api/v1/recipes?status=rejected"
    json_accepted_recipes = JSON.parse(response.body, symbolize_names: true)

    expect(json_accepted_recipes.size).to eq 2
    expect(json_accepted_recipes[0][:title]).to eq 'Bolo de limão'
    expect(json_accepted_recipes[1][:title]).to eq 'Bolo de morango'
    expect(json_accepted_recipes).not_to include 'Bolo de pessego'
    expect(json_accepted_recipes).not_to include 'Bolo de cenoura'
    expect(json_accepted_recipes).not_to include 'Bolo de laranja'
    expect(response).to have_http_status(200)
  end


  it 'filtered by pending ones' do
    user = User.create!(email: 'email@email.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create!(user: user, title: 'Bolo de cenoura', difficulty: 'Médio',
                   recipe_type: recipe_type, cuisine: cuisine,
                   cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos')
    Recipe.create!(user: user, title: 'Bolo de laranja', difficulty: 'Médio',
                   recipe_type: recipe_type, cuisine: cuisine,
                   cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos')
    Recipe.create!(user: user, title: 'Bolo de limão', difficulty: 'Médio',
                   recipe_type: recipe_type, cuisine: cuisine,
                   cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos')
    Recipe.create!(user: user, title: 'Bolo de pessego', difficulty: 'Médio',
                   recipe_type: recipe_type, cuisine: cuisine,
                   cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos')
    Recipe.create!(user: user, title: 'Bolo de morango', difficulty: 'Médio',
                   recipe_type: recipe_type, cuisine: cuisine,
                   cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                   status: 'rejected')
  
    get "/api/v1/recipes?status=pending"
    json_accepted_recipes = JSON.parse(response.body, symbolize_names: true)

    expect(json_accepted_recipes.size).to eq 4
    expect(json_accepted_recipes[0][:title]).to eq 'Bolo de cenoura'
    expect(json_accepted_recipes[1][:title]).to eq 'Bolo de laranja'
    expect(json_accepted_recipes[2][:title]).to eq 'Bolo de limão'
    expect(json_accepted_recipes[3][:title]).to eq 'Bolo de pessego'
    expect(json_accepted_recipes).not_to include 'Bolo de morango'
    expect(response).to have_http_status(200)
  end

  it 'returns status 404 if status is invalid' do
    get "/api/v1/recipes?status=qualquer_coisa_invalida"
    json_recipes = JSON.parse(response.body, symbolize_names: true)

    expect(json_recipes[:message]).to eq 'Status invalido'
    expect(response).to have_http_status(404)
  end
end
