# frozen_string_literal: true

require 'rails_helper'

feature 'User can view other users profile' do
  scenario 'successfully' do
    user = create(:user)
    other_user = create(:user, email: 'jane.doe@email.com',
                               name: 'Jane Doe')
    create(:recipe, title: 'Torta', user: other_user, status: 'accepted')

    login_as user
    visit root_path
    click_on 'Torta'
    click_on 'Enviado por: Jane Doe'

    expect(current_path).to eq("/pt-BR/users/#{other_user.id}")
    expect(page).to have_content("Perfil de #{other_user.name}")
    expect(page).to have_content("Receitas de #{other_user.name}")
  end

  scenario 'and the user must be logged in' do
    user = create(:user, email: 'jane.doe@email.com',
                         name: 'Jane Doe')
    create(:recipe, title: 'Torta', user: user, status: 'accepted')

    visit root_path
    click_on 'Torta'
    click_on 'Enviado por: Jane Doe'

    expect(current_path).to eq('/pt-BR')
  end

  scenario 'and the visitor cannot force visit the url link' do
    user = create(:user, email: 'john.doe1@email.com', admin: true)

    visit "/pt-BR/users/#{user.id}"

    expect(current_path).to eq('/pt-BR')
  end
end
