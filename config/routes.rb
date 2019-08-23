Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'

  resources :recipes, only: %i[index show new create edit update]
  resources :recipe_types, only: %i[show new create]
  resources :lists, only: %i[show new create]
  resources :cuisines, only: %i[show new create]

  get 'search/recipes', to: 'recipes#search'
  get 'user/my_recipes', to: 'recipes#my_recipes', as: 'my_recipes'
end
