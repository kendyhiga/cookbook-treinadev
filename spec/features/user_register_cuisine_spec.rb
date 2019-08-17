require 'rails_helper'

feature 'User register cuisine' do
  scenario 'sucessfully' do
    # Arrange

    # Act
    visit root_path
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_css('h1', text: 'Brasileira')
  end
end
