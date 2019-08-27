require 'rails_helper'

feature 'Admin must approve or reject recipe' do
  scenario 'reject' do
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    cuisine = Cuisine.create!(name: 'Brasileira')
    User.create!(email: 'admin@email.com', password: '123456', admin: true)
    another_user = User.create!(email: 'john.doe@email.com', password: '123456')
    Recipe.create!(title: 'Bolo de fubá', difficulty: 'Médio',
                   recipe_type: recipe_type, cuisine: cuisine,
                   cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,\
                                 misture com o restante dos ingredientes',
                   user: another_user)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'admin@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    click_on 'Receitas pendentes'
    click_on 'Bolo de fubá'
    click_on 'Rejeitar'

    expect(page).not_to have_css('p', text: 'Bolo de fubá')
  end

  scenario 'accept' do
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    cuisine = Cuisine.create!(name: 'Brasileira')
    User.create!(email: 'admin@email.com', password: '123456', admin: true)
    another_user = User.create!(email: 'john.doe@email.com', password: '123456')
    Recipe.create!(title: 'Bolo de fubá', difficulty: 'Médio',
                   recipe_type: recipe_type, cuisine: cuisine,
                   cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,\
                                 misture com o restante dos ingredientes',
                   user: another_user)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'admin@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    click_on 'Receitas pendentes'
    click_on 'Bolo de fubá'
    click_on 'Aceitar'
    click_on 'Início'

    expect(page).to have_css('p', text: 'Bolo de fubá')
  end

  scenario 'regular user cant see accept/reject buttons' do
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    cuisine = Cuisine.create!(name: 'Brasileira')
    user = User.create!(email: 'user@email.com', password: '123456')
    Recipe.create!(title: 'Bolo de fubá', difficulty: 'Médio',
                   recipe_type: recipe_type, cuisine: cuisine,
                   cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                   cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,\
                                 misture com o restante dos ingredientes',
                   user: user, status: 'accepted')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'user@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    click_on 'Bolo de fubá'

    expect(page).not_to have_content('Aceitar')
    expect(page).not_to have_content('Rejeitar')
  end
end