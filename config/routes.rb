Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'

  resources :recipes, only: %i[index show new create edit update]
  resources :recipe_types, only: %i[show new create]
  resources :lists, only: %i[show new create]
  resources :cuisines, only: %i[show new create]
  resources :recipe_lists, only: %i[create]

  get 'search/recipes', to: 'recipes#search'
  get 'user/my_recipes', to: 'users#my_recipes', as: 'my_recipes'
  get 'user/my_lists', to: 'users#my_lists', as: 'my_lists'
  delete 'list/:id/recipe/(.:recipe_id)', to: 'recipe_lists#destroy', as: 'remove_recipe_from_list'
end
