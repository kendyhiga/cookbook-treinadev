require 'rails_helper'

feature 'User register cuisine' do
  scenario 'sucessfully' do
    # Arrange

    # Act
    visit root_path
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_css('h1', text: 'Brasileira')
  end

  scenario 'and must fill in all fields' do
    # Arrange

    # Act
    visit root_path
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: ''
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content('Não foi possível salvar a cozinha')
  end

  scenario 'and the name should be unique' do
    # Arrange
    Cuisine.create(name: 'Brasileira')

    # Act
    visit root_path
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content('Não foi possível salvar a cozinha')
  end
end
