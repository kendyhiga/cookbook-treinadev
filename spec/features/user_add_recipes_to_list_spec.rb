require 'rails_helper'

feature 'User can add recipes to his list' do
  scenario 'successfully' do
    # Arrange
    user = User.create(email: 'alan@email.com', password: '123456', name: 'Alan')
    List.create!(name: 'Receitas low-carb', user: user)
    list = List.create!(name: 'Receitas favoritas', user: user)
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,\
                                misture com o restante dos ingredientes',
                  user: user, status: 'accepted')
    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar na sua conta'
    click_on 'Bolo de cenoura'
    select 'Receitas favoritas', from: 'Adicionar para a minha lista:'
    click_on 'Adicionar'
    click_on 'Meu perfil'
    click_on 'Listas de Alan'
    click_on 'Receitas favoritas'

    # Assert
    expect(page).to have_css('h1', text: 'Receitas favoritas')
    expect(page).to have_content('Bolo de cenoura')
    expect(list.recipes.size).to eq(1)
  end

  scenario 'and cannot add the same recipe for the same list twice' do
    # Arrange
    user = User.create(email: 'alan@email.com', password: '123456')
    List.create!(name: 'Receitas low-carb', user: user)
    list = List.create!(name: 'Receitas favoritas', user: user)
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,\
                                misture com o restante dos ingredientes',
                  user: user, status: 'accepted')
    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar na sua conta'
    click_on 'Bolo de cenoura'
    select 'Receitas favoritas', from: 'Adicionar para a minha lista:'
    click_on 'Adicionar'
    select 'Receitas favoritas', from: 'Adicionar para a minha lista:'
    click_on 'Adicionar'

    # Assert
    expect(page).to have_content('Esta receita ja foi adicionado a esta lista')
    expect(list.recipes.size).to eq(1)
  end
end