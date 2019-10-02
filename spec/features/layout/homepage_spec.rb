# frozen_string_literal: true

require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'Social Recipes')
  end

  scenario 'and view recipe' do
    # cria os dados necessarios
    recipe = create(:recipe, status: 'accepted')

    # simula a acao do usuario
    visit root_path

    # expectativas do usuario apos a acao
    expect(page).to have_css('p', text: recipe.title)
    expect(page).to have_css('p', text: recipe.cuisine.name)
    expect(page).to have_css('p', text: recipe.difficulty)
  end

  scenario 'and view recipes' do
    # cria os dados necessarios
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Italiana')
    user = User.create(email: 'alan@email.com', password: '123456')
    another_recipe_type = RecipeType.create(name: 'Prato principal')
    another_cuisine = Cuisine.create(name: 'Francesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços \
                                         pequenos, misture com os ingredientes',
                           user: user, status: 'accepted')
    other_recipe = Recipe.create(title: 'Feijoada',
                                 recipe_type: another_recipe_type,
                                 cuisine: another_cuisine, difficulty: 'Facil',
                                 cook_time: 90,
                                 ingredients: 'Feijão e carnes',
                                 cook_method: 'Misture o feijão com as carnes',
                                 user: user, status: 'accepted')

    # simula a acao do usuario
    visit root_path

    # expectativas do usuario apos a acao
    expect(page).to have_css('p', text: recipe.title)
    expect(page).to have_css('p', text: recipe.cuisine.name)
    expect(page).to have_css('p', text: recipe.difficulty)

    expect(page).to have_css('p', text: other_recipe.title)
    expect(page).to have_css('p', text: other_recipe.cuisine.name)
    expect(page).to have_css('p', text: other_recipe.difficulty)
  end

  scenario 'cannot see the users navbar links' do
    # Arrage

    # Act
    visit root_path

    # Assert
    expect(page).to have_content('Início')
    expect(page).to have_content('Entrar')
    expect(page).not_to have_content('Minhas receitas')
    expect(page).not_to have_content('Cadastrar receita')
    expect(page).not_to have_content('Meu perfil')
    expect(page).not_to have_content('Sair')
  end

  scenario 'and view only accepted recipes' do
    # Cria os dados necessarios
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Italiana')
    user = User.create(email: 'alan@email.com', password: '123456')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte e misture',
                  user: user, status: 'accepted')
    Recipe.create(title: 'Bolo de chocolate', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte e misture',
                  user: user, status: 'pending')
    Recipe.create(title: 'Bolo de fubá', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte e misture',
                  user: user, status: 'rejected')
    Recipe.create(title: 'Bolo de laranja', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte e misture',
                  user: user, status: 'accepted')
    # simula a acao do usuario
    visit root_path

    # expectativas do usuario apos a acao
    expect(page).to have_css('p', text: 'Bolo de cenoura')
    expect(page).to have_css('p', text: 'Bolo de laranja')
    expect(page).not_to have_css('p', text: 'Bolo de chocolate')
    expect(page).not_to have_css('p', text: 'Bolo de fubá')
  end
end
