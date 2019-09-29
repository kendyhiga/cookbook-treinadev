# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can edit any recipe' do
  scenario 'successfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    admin = User.create(email: 'admin@email.com', password: '123456',
                        admin: true)
    user = create(:user)
    RecipeType.create(name: 'Entrada')
    Recipe.create(title: 'Bolo de', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, '\
                               'misture com o restante dos ingredientes',
                  user: user, status: 'accepted')

    login_as admin
    visit root_path
    click_on 'Bolo de'
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
end
