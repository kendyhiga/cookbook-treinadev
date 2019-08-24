require 'rails_helper'

feature 'User register cuisine' do
  scenario 'sucessfully' do
    # Arrange
    User.create(email: 'alan@email.com', password: '123456', role: 'admin')

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    click_on 'Meu perfil'
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_css('h1', text: 'Brasileira')
  end

  scenario 'and must fill in all fields' do
    # Arrange
    User.create(email: 'alan@email.com', password: '123456', role: 'admin')

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    click_on 'Meu perfil'
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: ''
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content('Não foi possível salvar a cozinha')
  end

  scenario 'and the name should be unique' do
    # Arrange
    Cuisine.create(name: 'Brasileira')
    User.create(email: 'alan@email.com', password: '123456', role: 'admin')

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    click_on 'Meu perfil'
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content('Não foi possível salvar a cozinha')
  end
end
