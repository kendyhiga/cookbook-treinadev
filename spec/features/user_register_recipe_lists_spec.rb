require 'rails_helper'

feature 'User register recipe lists' do
  scenario 'successfully' do
    # Arrange
    User.create(email: 'alan@email.com', password: '123456')

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    click_on 'Cadastrar lista'
    fill_in 'Nome', with: 'Receitas Natalinas'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_css('h1', text: 'Receitas Natalinas')
  end
end
