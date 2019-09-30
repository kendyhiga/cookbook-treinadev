# frozen_string_literal: true

require 'rails_helper'

feature 'Visitor is able to see the footer content' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('small', text: 'Social Recipes | Copyright 2019')
    expect(page).to have_css('#github_logo')
    expect(page).to have_css('#linkedin_logo')
  end

  scenario 'and the github logo redirects to the repository page' do
    visit root_path

    expect(page).to have_selector(
      :css, 'a[href="https://github.com/kendyhiga/cookbook-treinadev"]'
    )
  end

  scenario 'and the linkedin logo redirects to the right linkedin page' do
    visit root_path

    expect(page).to have_selector(
      :css, 'a[href="https://www.linkedin.com/in/alan-kendy-higa-605a79158/"]'
    )
  end
end
