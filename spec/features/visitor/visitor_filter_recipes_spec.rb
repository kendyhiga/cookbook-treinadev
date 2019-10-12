# frozen_string_literal: true

require 'rails_helper'

feature 'User filter recipes' do
  before :each do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    other_recipe_type = RecipeType.create(name: 'Massa')
    cuisine = Cuisine.create(name: 'Brasileira')
    other_cuisine = Cuisine.create(name: 'Francesa')
    user = User.create(email: 'alan@email.com', password: '123456')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                  user: user, status: 'accepted')
    Recipe.create(title: 'Bolo de Fubá', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                  user: user, status: 'accepted')
    Recipe.create(title: 'Pão de Queijo', difficulty: 'Fácil',
                  recipe_type: other_recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, queijo',
                  cook_method: 'Misture, corte em pedaços pequenos',
                  user: user, status: 'accepted')
    Recipe.create(title: 'Bolo de Chocolate', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: other_cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                  user: user, status: 'accepted')
    Recipe.create(title: 'Bolo de Laranja', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: other_cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                  user: user, status: 'pending')
    Recipe.create(title: 'Bolo de Floresta Negra', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: other_cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                  user: user, status: 'pending')
  end

  context 'by its recipe type' do
    scenario 'successfully' do
      visit root_path
      click_on 'Sobremesa'

      expect(page).to have_content('Receitas filtradas por: Sobremesa')
      expect(page).to have_css('p', text: 'Bolo de cenoura')
      expect(page).to have_css('p', text: 'Bolo de Fubá')
      expect(page).to have_css('p', text: 'Bolo de Chocolate')
      expect(page).not_to have_content('Pão de Queijo')
    end

    scenario 'and a message appears if it contains no recipe' do
      RecipeType.create(name: 'Entrada')

      visit root_path
      click_on 'Entrada'

      expect(page).to have_content('Nenhuma receita deste tipo foi cadastrada '\
                                   'ainda')
    end

    scenario 'and it only returns accepted recipes' do
      visit root_path
      click_on 'Sobremesa'

      expect(page).to have_content('Receitas filtradas por: Sobremesa')
      expect(page).to have_css('p', text: 'Bolo de Chocolate')
      expect(page).to have_css('p', text: 'Bolo de cenoura')
      expect(page).to have_css('p', text: 'Bolo de Fubá')
      expect(page).not_to have_css('p', text: 'Bolo de Laranja')
      expect(page).not_to have_css('p', text: 'Bolo de Floresta Negra')
      expect(page).not_to have_content('Pão de Queijo')
    end
  end

  context 'by its cuisine' do
    scenario 'successfully' do
      visit root_path
      click_on 'Brasileira'

      expect(page).to have_content('Receitas filtradas por: Brasileira')
      expect(page).to have_css('p', text: 'Bolo de cenoura')
      expect(page).to have_css('p', text: 'Bolo de Fubá')
      expect(page).to have_css('p', text: 'Pão de Queijo')
      expect(page).not_to have_css('p', text: 'Bolo de Chocolate')
    end

    scenario 'and a message appears if it contains no recipe' do
      Cuisine.create(name: 'Mexicana')

      visit root_path
      click_on 'Mexicana'

      expect(page).to have_content('Nenhuma receita desta cozinha foi '\
                                   'cadastrada ainda')
    end

    scenario 'and it only returns accepted recipes' do
      visit root_path
      click_on 'Francesa'

      expect(page).to have_content('Receitas filtradas por: Francesa')
      expect(page).to have_css('p', text: 'Bolo de Chocolate')
      expect(page).not_to have_css('p', text: 'Bolo de cenoura')
      expect(page).not_to have_css('p', text: 'Bolo de Fubá')
      expect(page).not_to have_css('p', text: 'Bolo de Laranja')
      expect(page).not_to have_css('p', text: 'Bolo de Floresta Negra')
      expect(page).not_to have_content('Pão de Queijo')
    end
  end
end
