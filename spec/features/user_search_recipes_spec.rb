require 'rails_helper'

feature 'User search for recipes' do
  scenario 'sucessfully by its exact name' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    Recipe.create(title: 'Pão de Queijo', difficulty: 'Fácil',
                    recipe_type: recipe_type, cuisine: cuisine,
                    cook_time: 50, ingredients: 'Farinha, açucar, queijo',
                    cook_method: 'Misture, corte em pedaços pequenos, misture com o restante dos ingredientes')

    visit root_path
    click_on 'Pesquisar receita'
    fill_in 'Titulo:', with: 'Pão de Queijo'
    click_on 'Pesquisar'

    expect(page).to have_css('h1', text: 'Pão de Queijo')
    expect(page).not_to have_content('Bolo de cenoura')
  end
end