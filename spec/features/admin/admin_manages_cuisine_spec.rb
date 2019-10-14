# frozen_string_literal: true

require 'rails_helper'

feature 'Admin manages cuisines' do
  context 'and is able to create a new one' do
    scenario 'sucessfully' do
      # Arrange
      admin = create(:user, admin: true)

      # Act
      login_as admin
      visit root_path
      click_on 'Admin Area'
      click_on 'Gerenciar cozinhas'
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
      click_on 'Gerenciar cozinhas'
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
      click_on 'Gerenciar cozinhas'
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

  context 'is able to delete one cuisine' do
    scenario 'successfully' do
      # Arrange
      admin = create(:user, admin: true)
      create(:cuisine, name: 'Japonesa')
      create(:cuisine, name: 'Portuguesa')

      # Act
      login_as admin
      visit root_path
      click_on 'Admin Area'
      click_on 'Gerenciar cozinhas'
      within('#Portuguesa') do
        click_on 'Excluir'
      end

      # Assert
      expect(page).not_to have_css('td', text: 'Portuguesa')
    end
  end

  context 'is able to edit one cuisine' do
    scenario 'successfully' do
      # Arrange
      admin = create(:user, admin: true)
      create(:cuisine, name: 'jAPONESA')
      create(:cuisine, name: 'Portuguesa')

      # Act
      login_as admin
      visit root_path
      click_on 'Admin Area'
      click_on 'Gerenciar cozinhas'
      within('#jAPONESA') do
        click_on 'Editar'
      end
      fill_in 'Nome', with: 'Japonesa'
      click_on 'Cadastrar'

      # Assert
      expect(page).to have_content('Japonesa')
    end
  end
end
