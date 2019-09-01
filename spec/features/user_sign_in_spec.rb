require 'rails_helper'

feature 'User is able to log in' do
  scenario 'successfully' do
    # Arrange
    User.create(email: 'alan@email.com', password: '123456')

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar na sua conta'

    # Assert
    expect(page).to have_content('Minhas receitas')
    expect(page).to have_content('Cadastrar receita')
    expect(page).to have_content('Meu perfil')
    expect(page).to have_content('Sair')
    expect(page).not_to have_content('Entrar na sua conta')
  end

  scenario 'and then log out' do
    # Arrange
    User.create(email: 'alan@email.com', password: '123456')

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar na sua conta'
    click_on 'Sair'

    # Assert
    expect(page).to have_content('Entrar')
    expect(page).not_to have_content("Você esta logado como: alan@email.com")
    expect(page).not_to have_content('Sair')
  end
end