# frozen_string_literal: true

require 'rails_helper'

feature 'Admin manages recipe_type' do
  context 'creates new one' do
    scenario 'sucessfully' do
      # Arrange
      admin = create(:user, admin: true)

      # Act
      login_as admin
      visit root_path
      click_on 'Admin Area'
      click_on 'Gerenciar tipos de receitas'
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
      click_on 'Gerenciar tipos de receitas'
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
      click_on 'Gerenciar tipos de receitas'
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

  context 'is able to delete one recipe type' do
    scenario 'successfully' do
      # Arrange
      admin = create(:user, admin: true)
      create(:recipe_type, name: 'Sobremesa')
      create(:recipe_type, name: 'Salgado')

      # Act
      login_as admin
      visit root_path
      click_on 'Admin Area'
      click_on 'Gerenciar tipos de receitas'
      within('#Sobremesa') do
        click_on 'Excluir'
      end

      # Assert
      expect(page).not_to have_css('td', text: 'Sobremesa')
    end
  end

  context 'is able to edit one recipe type' do
    scenario 'successfully' do
      # Arrange
      admin = create(:user, admin: true)
      create(:recipe_type, name: 'SoBrEmEsA')
      create(:recipe_type, name: 'Salgado')

      # Act
      login_as admin
      visit root_path
      click_on 'Admin Area'
      click_on 'Gerenciar tipos de receitas'
      within('#SoBrEmEsA') do
        click_on 'Editar'
      end
      fill_in 'Nome', with: 'Sobremesa'
      click_on 'Cadastrar'

      # Assert
      expect(page).to have_content('Sobremesa')
    end
  end
end
