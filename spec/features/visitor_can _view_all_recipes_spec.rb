require 'rails_helper'

feature 'Visitor can view all recipes' do
  scenario 'successfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Italiana')
    user = User.create(email: 'alan@email.com', password: '123456')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: 'accepted')
    Recipe.create(title: 'Bolo de chocolate', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: 'accepted')
    Recipe.create(title: 'Bolo de fubá', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: 'accepted')
    Recipe.create(title: 'Bolo de laranja', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: 'accepted')

    # Act
    visit root_path
    click_on 'Todas as receitas'

    # Assert
    expect(page).to have_css('p', text: 'Bolo de cenoura')
    expect(page).to have_css('p', text: 'Bolo de laranja')
    expect(page).to have_css('p', text: 'Bolo de chocolate')
    expect(page).to have_css('p', text: 'Bolo de fubá')
  end

  scenario 'and view only accepted recipes' do
    #cria os dados necessários
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Italiana')
    user = User.create(email: 'alan@email.com', password: '123456')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: 'accepted')
    Recipe.create(title: 'Bolo de chocolate', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: 'pending')
    Recipe.create(title: 'Bolo de fubá', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: 'rejected')
    Recipe.create(title: 'Bolo de laranja', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: 'accepted')
    # simula a acao do usuário
    visit root_path
    click_on 'Todas as receitas'

    # expectativas do usuario apos a acao
    expect(page).to have_css('p', text: 'Bolo de cenoura')
    expect(page).to have_css('p', text: 'Bolo de laranja')
    expect(page).not_to have_css('p', text: 'Bolo de chocolate')
    expect(page).not_to have_css('p', text: 'Bolo de fubá')
  end
end