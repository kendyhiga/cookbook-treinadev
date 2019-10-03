# frozen_string_literal: true

require 'rails_helper'

feature 'Admin register recipe_type' do
  scenario 'sucessfully' do
    # Arrange
    admin = create(:user, admin: true)

    # Act
    login_as admin
    visit root_path
    click_on 'Admin Area'
    click_on 'Cadastrar tipo de receita'

    fill_in 'Nome', with: 'Aperitivo'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_css('h1', text: 'Aperitivo')
  end

  scenario 'and must fill in all fields' do
    # Arrange
    admin = create(:user, admin: true)

    # Act
    login_as admin
    visit root_path
    click_on 'Admin Area'
    click_on 'Cadastrar tipo de receita'
    fill_in 'Nome', with: ''
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content('Não foi possível salvar o tipo de receita')
  end

  scenario 'and the name should be unique' do
    # Arrange
    admin = create(:user, admin: true)
    RecipeType.create(name: 'Salada')

    # Act
    login_as admin
    visit root_path
    click_on 'Admin Area'
    click_on 'Cadastrar tipo de receita'
    fill_in 'Nome', with: 'Salada'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content('Não foi possível salvar o tipo de receita')
  end

  scenario 'and the user cant see the register recipe_type link' do
    # Arrange
    user = create(:user)

    # Act
    login_as user
    visit root_path

    # Assert
    expect(page).not_to have_content('Admin Area')
  end

  scenario 'and the user cant force to visit the register recipe_type page' do
    # Arrange
    user = create(:user)

    # Act
    login_as user
    visit new_recipe_type_path

    # Assert
    expect(current_path).to eq('/pt-BR')
  end
end
