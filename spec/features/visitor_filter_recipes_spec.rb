require 'rails_helper'

feature 'User filter recipes' do
  context 'by its recipe type' do
    scenario 'successfully' do
      recipe_type = RecipeType.create(name: 'Sobremesa')
      other_recipe_type = RecipeType.create(name: 'Massa')
      cuisine = Cuisine.create(name: 'Brasileira')
      user = User.create(email: 'alan@email.com', password: '123456')
      Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: cuisine,
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                    user: user)
      Recipe.create(title: 'Bolo de Fubá', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: cuisine,
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                    user: user)
      Recipe.create(title: 'Pão de Queijo', difficulty: 'Fácil',
                    recipe_type: other_recipe_type, cuisine: cuisine,
                    cook_time: 50, ingredients: 'Farinha, açucar, queijo',
                    cook_method: 'Misture, corte em pedaços pequenos',
                    user: user)
      Recipe.create(title: 'Bolo de Chocolate', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: cuisine,
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                    user: user)

      visit root_path
      click_on 'Sobremesa'

      expect(page).to have_content('Receitas filtradas por tipo: Sobremesa')
      expect(page).to have_css('p', text: 'Bolo de cenoura')
      expect(page).to have_css('p', text: 'Bolo de Fubá')
      expect(page).to have_css('p', text: 'Bolo de Chocolate')
      expect(page).not_to have_content('Pão de Queijo')
    end

    scenario 'and a message appears if it contains no recipe' do
      RecipeType.create(name: 'Sobremesa')

      visit root_path
      click_on 'Sobremesa'

      expect(page).to have_content('Nenhuma receita deste tipo foi cadastrada ainda')
    end
  end

  context 'by its cuisine' do
    scenario 'successfully' do
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira')
      other_cuisine = Cuisine.create(name: 'Universal')
      user = User.create(email: 'alan@email.com', password: '123456')
      Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: cuisine,
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                    user: user)
      Recipe.create(title: 'Bolo de Fubá', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: cuisine,
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                    user: user)
      Recipe.create(title: 'Pão de Queijo', difficulty: 'Fácil',
                    recipe_type: recipe_type, cuisine: cuisine,
                    cook_time: 50, ingredients: 'Farinha, açucar, queijo',
                    cook_method: 'Misture, corte em pedaços pequenos',
                    user: user)
      Recipe.create(title: 'Bolo de Chocolate', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: other_cuisine,
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos',
                    user: user)

      visit root_path
      click_on 'Brasileira'

      expect(page).to have_content('Receitas filtradas por cozinha: Brasileira')
      expect(page).to have_css('p', text: 'Bolo de cenoura')
      expect(page).to have_css('p', text: 'Bolo de Fubá')
      expect(page).to have_css('p', text: 'Pão de Queijo')
      expect(page).not_to have_css('p', text: 'Bolo de Chocolate')
    end

    scenario 'and a message appears if it contains no recipe' do
      Cuisine.create(name: 'Brasileira')

      visit root_path
      click_on 'Brasileira'

      expect(page).to have_content('Nenhuma receita desta cozinha foi cadastrada ainda')
    end
  end
end
