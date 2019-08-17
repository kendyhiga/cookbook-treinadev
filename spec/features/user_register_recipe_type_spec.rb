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

  scenario 'and must fill in all fields' do
    # Arrange

    # Act
    visit root_path
    click_on 'Enviar um tipo de receita'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Não foi possível salvar o tipo de receita')
  end

  scenario 'and the name should be unique' do
    # Arrange
    RecipeType.create(name: 'Salada')

    # Act
    visit root_path
    click_on 'Enviar um tipo de receita'
    fill_in 'Nome', with: 'Salada'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Não foi possível salvar o tipo de receita')
  end
end
