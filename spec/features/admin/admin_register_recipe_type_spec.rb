# frozen_string_literal: true

require 'rails_helper'

feature 'Admin register recipe_type' do
  scenario 'sucessfully' do
    # Arrange
    User.create(email: 'alan@email.com', password: '123456', admin: true)

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar na sua conta'
    click_on 'Meu perfil'
    click_on 'Cadastrar tipo de receita'

    fill_in 'Nome', with: 'Aperitivo'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_css('h1', text: 'Aperitivo')
  end

  scenario 'and must fill in all fields' do
    # Arrange
    User.create(email: 'alan@email.com', password: '123456', admin: true)

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar na sua conta'
    click_on 'Meu perfil'
    click_on 'Cadastrar tipo de receita'
    fill_in 'Nome', with: ''
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content('Não foi possível salvar o tipo de receita')
  end

  scenario 'and the name should be unique' do
    # Arrange
    User.create(email: 'alan@email.com', password: '123456', admin: true)
    RecipeType.create(name: 'Salada')

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar na sua conta'
    click_on 'Meu perfil'
    click_on 'Cadastrar tipo de receita'
    fill_in 'Nome', with: 'Salada'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content('Não foi possível salvar o tipo de receita')
  end

  scenario 'and the user cant see the register recipe_type link' do
    # Arrange
    Cuisine.create(name: 'Brasileira')
    User.create(email: 'email@email.com', password: '123456')

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'email@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar na sua conta'
    click_on 'Meu perfil'

    # Assert
    expect(page).not_to have_content('Cadastrar tipo de receita')
  end
  scenario 'and the user cant force to visit the register recipe_type page' do
    # Arrange
    Cuisine.create(name: 'Brasileira')
    User.create(email: 'email@email.com', password: '123456')

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'email@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar na sua conta'
    visit new_recipe_type_path

    # Assert
    expect(current_path).to eq('/pt-BR')
  end
end
