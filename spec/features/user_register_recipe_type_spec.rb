require 'rails_helper'

feature 'User register recipe_type' do
  scenario 'sucessfully' do
    # Arrange
    RecipeType.create(name: 'Massa')
    RecipeType.create(name: 'Salada')

    # Act
    visit root_path
    click_on 'Enviar um tipo de receita'

    fill_in 'Nome', with: 'Aperitivo'
    click_on 'Enviar'

    # Assert
    expect(page).to have_css('h1', text: 'Aperitivo')
  end
end