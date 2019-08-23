require 'rails_helper'

feature 'User can add recipes to his list' do
  scenario 'successfully' do
    # Arrange
    user = User.create(email: 'alan@email.com', password: '123456')
    List.create!(name: 'Receitas low-carb', user: user)
    List.create!(name: 'Receitas favoritas', user: user)
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,\
                                misture com o restante dos ingredientes',
                  user: user)
    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    click_on 'Bolo de cenoura'
    select 'Receitas favoritas', from: 'Adicionar para a minha lista:'
    click_on 'Adicionar'
    click_on 'Minhas listas'
    click_on 'Receitas favoritas'

    # Assert
    expect(page).to have_content('Bolo de cenoura')
  end
end