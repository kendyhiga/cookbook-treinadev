require 'rails_helper'

feature 'User register recipe_type' do
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
    click_on 'Cadastrar tipo de receita'

    fill_in 'Nome', with: 'Aperitivo'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_css('h1', text: 'Aperitivo')
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
    click_on 'Cadastrar tipo de receita'
    fill_in 'Nome', with: ''
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content('Não foi possível salvar o tipo de receita')
  end

  scenario 'and the name should be unique' do
    # Arrange
    User.create(email: 'alan@email.com', password: '123456', role: 'admin')
    RecipeType.create(name: 'Salada')

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    click_on 'Meu perfil'
    click_on 'Cadastrar tipo de receita'
    fill_in 'Nome', with: 'Salada'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content('Não foi possível salvar o tipo de receita')
  end
end
