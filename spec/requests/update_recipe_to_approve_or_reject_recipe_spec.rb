# frozen_string_literal: true

require 'rails_helper'

describe 'User can approve or reject recipe' do
  before :each do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine, name: 'Brasileira')
    @recipe = create(:recipe, user: user, recipe_type: recipe_type,
                              cuisine: cuisine)
  end

  describe 'rejects' do
    it 'successfully' do
      post api_v1_reject_recipe_path(@recipe.id)
      json_recipe = JSON.parse(response.body, symbolize_names: true)

      expect(json_recipe[:status]).to eq 'rejected'
    end

    it 'an the recipe does not exist' do
      post api_v1_reject_recipe_path(555)
      json_recipe = JSON.parse(response.body, symbolize_names: true)

      expect(json_recipe[:message]).to eq 'Receita não encontrada'
      expect(response).to have_http_status(404)
    end
  end

  describe 'accepts' do
    it 'successfully' do
      post api_v1_accept_recipe_path(@recipe.id)
      json_recipe = JSON.parse(response.body, symbolize_names: true)

      expect(json_recipe[:status]).to eq 'accepted'
    end

    it 'and the recipe does not exist' do
      post api_v1_accept_recipe_path(69)
      json_recipe = JSON.parse(response.body, symbolize_names: true)

      expect(json_recipe[:message]).to eq 'Receita não encontrada'
      expect(response).to have_http_status(404)
    end
  end
end
