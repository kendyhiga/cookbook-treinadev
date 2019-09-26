# frozen_string_literal: true

require 'rails_helper'

feature 'User can view his profile' do
  scenario 'successfully' do
    user = create(:user, email: 'john.doe1@email.com', admin: true)

    login_as user
    visit root_path
    click_on 'Meu perfil'

    expect(page).to have_css('h1', text: "Perfil de #{user.name}")
    expect(page).to have_content("Receitas de #{user.name}")
  end

  scenario 'and the user must be logged in' do
    visit root_path

    expect(page).not_to have_content('Meu perfil')
  end

  scenario 'and the visitor cannot force visit the url link' do
    create(:user, email: 'john.doe1@email.com', admin: true)

    visit user_path(1)

    expect(current_path).to eq root_path
  end
end
