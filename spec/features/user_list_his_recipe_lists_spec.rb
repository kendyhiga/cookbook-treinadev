require 'rails_helper'

feature 'User can list his recipe lists' do
  scenario 'successfully' do
    # Arrange
    user = User.create(email: 'alan@email.com', password: '123456')
    another_user = User.create(email: 'john.doe@email.com', password: '123456')
    List.create!(name: 'Receitas favoritas', user: user)
    List.create!(name: 'Receitas Vegetarianas', user: user)
    List.create!(name: 'Receitas Veganas', user: another_user)

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    click_on 'Minhas listas'

    # Assert
    expect(page).to have_content('Minhas listas:')
    expect(page).to have_css('ul', text: 'Receitas favoritas')
    expect(page).to have_css('ul', text: 'Receitas Vegetarianas')
    expect(page).not_to have_content('Receitas Veganas')
  end

  scenario 'and receives a message if he doesnt have any list' do
    # Arrange
    User.create(email: 'alan@email.com', password: '123456')

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    click_on 'Minhas listas'

    # Assert
    expect(page).to have_content('Você não tem nenhuma lista cadastrada em nosso site')
  end
end
