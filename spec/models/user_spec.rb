require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_db_column(:email).of_type(:string) }
  it { is_expected.to have_db_column(:encrypted_password).of_type(:string) }
  it { is_expected.to have_db_column(:reset_password_token).of_type(:string) }

  context '#can_edit?' do
    it 'is able to edit the recipe' do
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira')
      user = User.create(email: 'alan@email.com', password: '123456')
      recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: cuisine,
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,\
                                  misture com o restante dos ingredientes',
                    user: user)

      expect(user.can_edit?(recipe)).to eq true
    end

    it 'is unable to edit the recipe' do
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira')
      user = User.create(email: 'alan@email.com', password: '123456')
      another_user = User.create(email: 'john.doe@email.com', password: '123456')
      recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: cuisine,
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,\
                                  misture com o restante dos ingredientes',
                    user: another_user)

      expect(user.can_edit?(recipe)).to eq false
    end

    it 'receives no argument' do
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira')
      user = User.create(email: 'alan@email.com', password: '123456')
      another_user = User.create(email: 'john.doe@email.com', password: '123456')
      recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: cuisine,
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos,\
                                  misture com o restante dos ingredientes',
                    user: another_user)

      expect(user.can_edit?()).to eq false
    end
  end
end
