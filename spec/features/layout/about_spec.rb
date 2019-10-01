# frozen_string_literal: true

require 'rails_helper'

feature 'Visitor is able to see the about page content' do
  scenario 'successfully' do
    visit root_path
    click_on 'Sobre'

    expect(page).to have_content(
      'Este site foi feito com intuito de aprender, praticar e fixar os '\
      'conceitos de programação web, vistos em cursos, artigos e materiais '\
      'diversos.'
    )
    expect(page).to have_content('Sinta-se livre para criticar, sugerir '\
      'melhorias ou opinar aleatóriamente! Você pode encontrar meus '\
      'contatos (Github, Linkedin) no rodapé.')
  end
end
