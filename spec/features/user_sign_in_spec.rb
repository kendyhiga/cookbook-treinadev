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
    click_on 'Logar'

    # Assert
    expect(page).to have_content("Você esta logado como: alan@email.com")
    expect(page).to have_content('Sair')
    expect(page).not_to have_content('Entrar')
  end

  scenario 'and then log out' do
    # Arrange
    User.create(email: 'alan@email.com', password: '123456')

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    click_on 'Sair'

    # Assert
    expect(page).to have_content('Entrar')
    expect(page).not_to have_content("Você esta logado como: alan@email.com")
    expect(page).not_to have_content('Sair')
  end
end