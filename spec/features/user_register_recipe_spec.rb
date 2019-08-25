require 'rails_helper'

feature 'User register recipe' do
  scenario 'successfully' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    Cuisine.create(name: 'Brasileira')
    Cuisine.create(name: 'Arabe')
    User.create(email: 'alan@email.com', password: '123456', name: 'Alan')

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Logar'

    click_on 'Cadastrar receita'
    fill_in 'Título', with: 'Tabule'
    select 'Entrada', from: 'Tipo da Receita'
    select 'Arabe', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    click_on 'Enviar'

    # expectativas
    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('p', text: 'Enviado por: Alan')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('td', text: 'Entrada')
    expect(page).to have_css('td', text: 'Arabe')
    expect(page).to have_css('td', text: 'Fácil')
    expect(page).to have_css('td', text: "45 minutos")
    expect(page).to have_css('td', text: 'Ingredientes')
    expect(page).to have_css('td', text: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha')
    expect(page).to have_css('td', text: 'Como Preparar')
    expect(page).to have_css('td', text:  'Misturar tudo e servir. Adicione limão a gosto.')
  end

  scenario 'and must fill in all fields' do
    User.create(email: 'alan@email.com', password: '123456')

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alan@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    click_on 'Cadastrar receita'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a receita')
  end

  scenario 'and must be logged in' do
    # Act
    visit root_path

    # Assert
    expect(page).not_to have_css('h1', text: 'Cadastrar nova receita')
  end
end
