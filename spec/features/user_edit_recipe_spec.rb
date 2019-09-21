# frozen_string_literal: true

require 'rails_helper'

feature 'User update recipe' do
  scenario 'successfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'alan@email.com', password: '123456')
    RecipeType.create(name: 'Entrada')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, '\
                               'misture com o restante dos ingredientes',
                  user: user, status: 'accepted')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar na sua conta'
    click_on 'Bolo de cenoura'
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo, oleo de soja e '\
                                  'chocolate'
    fill_in 'Como Preparar', with: 'Faça um bolo e uma cobertura de chocolate'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('td', text: 'Médio')
    expect(page).to have_css('td', text: '45 minutos')
    expect(page).to have_css('td', text: 'Cenoura, farinha, ovo, oleo de soja '\
                                         'e chocolate')
    expect(page).to have_css('td', text: 'Faça um bolo e uma cobertura de '\
                                         'chocolate')
  end

  scenario 'and must fill in all fields' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'alan@email.com', password: '123456')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, \
                                misture com o restante dos ingredientes',
                  user: user, status: 'accepted')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar na sua conta'

    click_on 'Bolo de cenoura'
    click_on 'Editar'
    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a receita')
  end

  scenario 'and must be logged in' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'alan@email.com', password: '123456')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, '\
                               'misture com o restante dos ingredientes',
                  user: user, status: 'accepted')

    visit root_path
    click_on 'Bolo de cenoura'

    expect(page).not_to have_content('Editar')
  end

  scenario 'and must be the owner' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    User.create(email: 'alan@email.com', password: '123456')
    another_user = User.create(email: 'john.doe@email.com', password: '123456')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, '\
                               'misture com o restante dos ingredientes',
                  user: another_user, status: 'accepted')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar na sua conta'
    click_on 'Bolo de cenoura'

    expect(page).not_to have_content('Editar')
  end

  scenario 'and cannot access de edit recipe url if he is not the owner' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    User.create(email: 'alan@email.com', password: '123456')
    another_user = User.create(email: 'john.doe@email.com', password: '123456')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços \
                                         pequenos, misture com o restante dos \
                                         ingredientes',
                           user: another_user)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar na sua conta'
    visit edit_recipe_path(recipe.id)

    expect(current_path).to eq root_path
  end
end
