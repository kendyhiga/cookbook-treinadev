# frozen_string_literal: true

require 'rails_helper'

feature 'Visitor is able to register' do
  scenario 'successfully' do
    visit root_path
    click_on 'Entrar'
    click_on 'Cadastrar-se'
    fill_in 'Nome', with: 'John Doe'
    fill_in 'Email', with: 'johndoe@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Registrar-se'

    # expectativas
    expect(page).to have_content('Login efetuado com sucesso. Se não foi'\
                                 ' autorizado, a confirmação será enviada'\
                                 ' por e-mail.')
  end

  scenario 'and the name is saved' do
    visit root_path
    click_on 'Entrar'
    click_on 'Cadastrar-se'
    fill_in 'Nome', with: 'John Doe'
    fill_in 'Email', with: 'johndoe@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Registrar-se'
    click_on 'Meu perfil'

    # expectativas
    expect(page).to have_content('Perfil de John Doe')
    expect(page).to have_content('Listas de John Doe')
    expect(page).to have_content('Receitas de John Doe')
  end
end
