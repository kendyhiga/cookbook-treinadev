require 'rails_helper'

feature 'User can list his recipes' do
  scenario 'successfully' do
    # Arrange
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'alan@email.com', password: '123456')
    other_user = User.create(email: 'john.doe@email.com', password: '123456')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)
    Recipe.create(title: 'Bolo de Fubá', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: cuisine,
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                    user: user)
    Recipe.create(title: 'Bolo de Chocolate', difficulty: 'Médio',
                      recipe_type: recipe_type, cuisine: cuisine,
                      cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                      user: user)
    Recipe.create(title: 'Pão de Queijo', difficulty: 'Fácil',
                        recipe_type: recipe_type, cuisine: cuisine,
                        cook_time: 50, ingredients: 'Farinha, açucar, queijo',
                        cook_method: 'Misture, corte em pedaços pequenos, misture com o restante dos ingredientes',
                        user: other_user)

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar na sua conta'
    click_on 'Minhas receitas'

    # Assert
    expect(page).to have_content('Minhas receitas:')
    expect(page).to have_css('p', text: 'Bolo de cenoura')
    expect(page).to have_css('p', text: 'Bolo de Fubá')
    expect(page).to have_css('p', text: 'Bolo de Chocolate')
    expect(page).not_to have_content('Pão de Queijo')
  end

  scenario 'and receives a message if he doesnt have any recipe' do
    # Arrange
    User.create(email: 'alan@email.com', password: '123456')

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar na sua conta'
    click_on 'Minhas receitas'

    # Assert
    expect(page).to have_content('Você não tem nenhuma receita cadastrada em nosso site')
  end
end
