require 'rails_helper'

feature 'Admin register cuisine' do
  scenario 'sucessfully' do
    # Arrange
    User.create(email: 'alan@email.com', password: '123456', admin: true)

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
    User.create(email: 'alan@email.com', password: '123456', admin: true)

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
    User.create(email: 'alan@email.com', password: '123456', admin: true)

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

  scenario 'and the guest user cant see the register cuisine link' do
    # Arrange
    Cuisine.create(name: 'Brasileira')
    User.create(email: 'email@email.com', password: '123456')

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'email@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    click_on 'Meu perfil'

    # Assert
    expect(page).not_to have_content('Cadastrar cozinha')
  end

  scenario 'and the guest user cant force to visit the register cuisine page' do
    # Arrange
    Cuisine.create(name: 'Brasileira')
    User.create(email: 'email@email.com', password: '123456')

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'email@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    visit new_cuisine_path

    # Assert
    expect(current_path).to eq root_path
  end
end
