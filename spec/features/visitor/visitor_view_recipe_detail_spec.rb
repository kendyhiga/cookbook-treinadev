# frozen_string_literal: true

require 'rails_helper'

feature 'Visitor view recipe details' do
  scenario 'successfully' do
    # cria os dados necessarios
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Italiana')
    user = User.create(email: 'doe@email.com', password: '123456', name: 'Doe')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços,'\
                                        'misture com os outros ingredientes',
                           user: user, status: 'accepted')

    # simula a ação do usuário
    visit root_path
    click_on recipe.title

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('p', text: 'Enviado por: Doe')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('td', text: recipe.recipe_type.name)
    expect(page).to have_css('td', text: recipe.cuisine.name)
    expect(page).to have_css('td', text: recipe.difficulty)
    expect(page).to have_css('td', text: "#{recipe.cook_time} minutos")
    expect(page).to have_css('td', text: 'Ingredientes')
    expect(page).to have_css('td', text: recipe.ingredients)
    expect(page).to have_css('td', text: 'Como Preparar')
    expect(page).to have_css('td', text: recipe.cook_method)
  end

  scenario 'and return to recipes index' do
    # cria os dados necessários
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Italiana')
    user = User.create(email: 'alan@email.com', password: '123456')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços
                           pequenos, misture com o restante dos ingredientes',
                           user: user, status: 'accepted')

    # simula a ação do usuário
    visit root_path
    click_on recipe.title
    click_on 'Voltar'

    # expectativa da rota atual
    expect(current_path).to eq(root_path)
  end

  scenario 'and cant access a non accepted recipe, if he is not the owner' do
    # cria os dados necessários
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Italiana')
    user = User.create(email: 'alan@email.com', password: '123456')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços
                           pequenos, misture com o restante dos ingredientes',
                           user: user, status: 'pending')

    # simula a acao do usuário
    visit "/recipes/#{recipe.id}/"

    # expectativa da rota atual
    expect(current_path).to eq(root_path)
  end
end
