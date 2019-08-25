require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'Social Recipes')
  end

  scenario 'and view recipe' do
    #cria os dados necessários
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Italiana')
    user = User.create(email: 'alan@email.com', password: '123456')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                           user: user)

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('p', text: recipe.title)
    expect(page).to have_css('p', text: recipe.cuisine.name)
    expect(page).to have_css('p', text: recipe.difficulty)
  end

  scenario 'and view recipes' do
    #cria os dados necessários
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Italiana')
    user = User.create(email: 'alan@email.com', password: '123456')
    another_recipe_type = RecipeType.create(name: 'Prato principal')
    another_cuisine = Cuisine.create(name: 'Francesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                           user: user)

    another_recipe = Recipe.create(title: 'Feijoada',
                                   recipe_type: another_recipe_type,
                                   cuisine: another_cuisine, difficulty: 'Difícil',
                                   cook_time: 90,
                                   ingredients: 'Feijão e carnes',
                                   cook_method: 'Misture o feijão com as carnes',
                                   user: user)

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('p', text: recipe.title)
    expect(page).to have_css('p', text: recipe.cuisine.name)
    expect(page).to have_css('p', text: recipe.difficulty)

    expect(page).to have_css('p', text: another_recipe.title)
    expect(page).to have_css('p', text: another_recipe.cuisine.name)
    expect(page).to have_css('p', text: another_recipe.difficulty)
  end

  scenario 'cannot see the correct navbar links' do
    #Arrage

    #Act
    visit root_path

    #Assert
    expect(page).to have_content('Início')
    expect(page).to have_content('Entrar')
    expect(page).not_to have_content('Minhas receitas')
    expect(page).not_to have_content('Cadastrar receita')
    expect(page).not_to have_content('Meu perfil')
    expect(page).not_to have_content('Sair')
  end
end
