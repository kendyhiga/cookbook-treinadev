require 'rails_helper'

feature 'User register recipe lists' do
  scenario 'successfully' do
    # Arrange
    User.create(email: 'alan@email.com', password: '123456', admin: true)

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar na sua conta'
    click_on 'Meu perfil'
    click_on 'Cadastrar lista'
    fill_in 'Nome', with: 'Receitas Natalinas'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_css('h1', text: 'Receitas Natalinas')
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
    click_on 'Cadastrar lista'
    fill_in 'Nome', with: ''
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content('Não foi possível salvar a lista')
  end

  scenario 'and the list name must be unique' do
    # Arrange
    user = User.create(email: 'alan@email.com', password: '123456', admin: true)
    List.create!(name: 'Receitas favoritas', user: user)

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar na sua conta'
    click_on 'Meu perfil'
    click_on 'Cadastrar lista'
    fill_in 'Nome', with: 'Receitas favoritas'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content('Não foi possível salvar a lista')
  end

  scenario 'and the list name can repeat to different users' do
    # Arrange
    other_user = User.create(email: 'email@email.com', password: '123456')
    List.create!(name: 'Receitas favoritas', user: other_user)

    User.create(email: 'alan@email.com', password: '123456', admin: true)

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar na sua conta'
    click_on 'Meu perfil'
    click_on 'Cadastrar lista'
    fill_in 'Nome', with: 'Receitas favoritas'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_css('h1', text: 'Receitas favoritas')
  end
end
