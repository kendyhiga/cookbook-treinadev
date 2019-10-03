# frozen_string_literal: true

require 'rails_helper'

feature 'Admin register cuisine' do
  scenario 'sucessfully' do
    # Arrange
    admin = create(:user, admin: true)

    # Act
    login_as admin
    visit root_path
    click_on 'Admin Area'
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_css('h1', text: 'Brasileira')
  end

  scenario 'and must fill in all fields' do
    # Arrange
    admin = create(:user, admin: true)

    # Act
    login_as admin
    visit root_path
    click_on 'Admin Area'
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: ''
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content('Não foi possível salvar a cozinha')
  end

  scenario 'and the name should be unique' do
    # Arrange
    Cuisine.create(name: 'Brasileira')
    admin = create(:user, admin: true)

    # Act
    login_as admin
    visit root_path
    click_on 'Admin Area'
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content('Não foi possível salvar a cozinha')
  end

  scenario 'and the user cant see the register cuisine link' do
    # Arrange
    user = create(:user)

    # Act
    login_as user
    visit root_path

    # Assert
    expect(page).not_to have_content('Admin Area')
  end

  scenario 'and the user cant force to visit the register cuisine page' do
    # Arrange
    user = create(:user)

    # Act
    login_as user
    visit new_cuisine_path

    # Assert
    expect(current_path).to eq('/pt-BR')
  end
end
