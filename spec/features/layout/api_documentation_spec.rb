# frozen_string_literal: true

require 'rails_helper'

feature 'Visitor is able to see the API doc page' do
  scenario 'successfully' do
    visit root_path
    click_on 'Documentação da API'

    expect(page).to have_content('Documentação da API')
    expect(page).to have_content('GET')
  end
end
