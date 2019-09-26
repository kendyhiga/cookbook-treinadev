# frozen_string_literal: true

require 'rails_helper'

feature 'User can remove recipes from list' do
  scenario 'successfully' do
    # Arrange
    user = User.create!(email: 'alan@email.com', password: '123456',
                        name: 'Alan')
    List.create!(name: 'Receitas low-carb', user: user)
    list = List.create!(name: 'Receitas favoritas', user: user)
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    cuisine = Cuisine.create!(name: 'Brasileira')
    recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
                            recipe_type: recipe_type, cuisine: cuisine,
                            cook_time: 50,
                            ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe, corte, misture',
                            user: user)
    RecipeList.create!(recipe: recipe, list: list)

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar na sua conta'
    click_on 'Meu perfil'
    click_on 'Listas de Alan'
    click_on 'Receitas favoritas'
    click_on 'Remover da lista'

    # Assert
    expect(page).to have_content 'Receita Bolo de cenoura foi removida da lista'
    expect(list.recipes.size).to eq(0)
  end
end
