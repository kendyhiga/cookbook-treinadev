# frozen_string_literal: true

require 'rails_helper'

feature 'Visitor search for recipes' do
  before :each do
    user = create(:user)
    recipe_type = create(:recipe_type, name: 'Bolo')
    cuisine = create(:cuisine)
    create(:recipe, title: 'Bolo de cenoura', user: user,
                    recipe_type: recipe_type, cuisine: cuisine)
    create(:recipe, title: 'Pão de Queijo', user: user,
                    recipe_type: recipe_type, cuisine: cuisine)
  end

  scenario 'sucessfully by its exact name' do
    visit root_path
    click_on 'Pesquisar no site'
    fill_in 'Título', with: 'Pão de Queijo'
    click_on 'Pesquisar'

    expect(page).to have_css('h3', text: 'Receitas encontradas')
    expect(page).to have_css('p', text: 'Pão de Queijo')
    expect(page).not_to have_content('Bolo de cenoura')
  end

  scenario 'and must fill title field to search' do
    visit root_path
    click_on 'Pesquisar no site'
    fill_in 'Título', with: 'Bolo de fubá'
    click_on 'Pesquisar'

    expect(page).not_to have_content('Receitas encontradas')
    expect(page).not_to have_content('Bolo de cenoura')
    expect(page).to have_content('Não encontramos nada')
  end

  scenario 'by unexistant recipe and none is shown' do
    visit root_path
    click_on 'Pesquisar no site'
    fill_in 'Título', with: ''
    click_on 'Pesquisar'

    expect(page).not_to have_content('Receitas encontradas')
    expect(page).not_to have_content('Bolo de cenoura')
    expect(page).to have_content('Preencha o campo de pesquisa')
  end

  scenario 'by its partial name and can show more than one result' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'alan@email.com', password: '123456')
    create(:recipe, title: 'Bolo de Fubá', user: user,
                    recipe_type: recipe_type, cuisine: cuisine)
    create(:recipe, title: 'Bolo de Chocolate', user: user,
                    recipe_type: recipe_type, cuisine: cuisine)

    visit root_path
    click_on 'Pesquisar no site'
    fill_in 'Título', with: 'Bolo'
    click_on 'Pesquisar'

    expect(page).to have_content('Receitas encontradas')
    expect(page).to have_css('p', text: 'Bolo de cenoura')
    expect(page).to have_css('p', text: 'Bolo de Fubá')
    expect(page).to have_css('p', text: 'Bolo de Chocolate')
    expect(page).not_to have_content('Pão de Queijo')
  end

  scenario 'and it is case unsensitive' do
    visit root_path
    click_on 'Pesquisar no site'
    fill_in 'Título', with: 'pão de queijo'
    click_on 'Pesquisar'

    expect(page).to have_css('h3', text: 'Receitas encontradas')
    expect(page).to have_css('p', text: 'Pão de Queijo')
    expect(page).not_to have_content('Bolo de cenoura')
  end
end
