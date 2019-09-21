# frozen_string_literal: true

require 'rails_helper'

RSpec.describe List, type: :model do
  it { is_expected.to have_db_column(:name).of_type(:string) }

  context 'references are working' do
    it 'has many recipes' do
      recipe_type = RecipeType.create!(name: 'Sobremesa')
      cuisine = Cuisine.create!(name: 'Brasileira')
      user = User.create!(email: 'alan@email.com', password: '123456')
      recipe = create(:recipe, recipe_type: recipe_type, cuisine: cuisine,
                               user: user)
      other_recipe = create(:recipe, title: 'Cupcake', recipe_type: recipe_type,
                                     cuisine: cuisine, user: user)
      list = List.create!(name: 'Receitas favoritas', user: user)

      RecipeList.create!(recipe: recipe, list: list)
      RecipeList.create!(recipe: other_recipe, list: list)

      expect(list.recipes).to include recipe
      expect(list.recipes).to include other_recipe
    end
  end
end
