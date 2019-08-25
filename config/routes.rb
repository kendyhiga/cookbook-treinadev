Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'

  resources :recipes, only: %i[index show new create edit update]
  resources :recipe_types, only: %i[show new create]
  resources :lists, only: %i[show new create]
  resources :cuisines, only: %i[show new create]
  resources :recipe_lists, only: %i[create]
  resources :users, only: %i[show]

  get 'recipe/all', to: 'recipes#all', as: 'all_recipes'
  get 'search', to: 'users#search'
  get 'user/my_recipes', to: 'users#my_recipes', as: 'my_recipes'
  get 'user/:id/lists', to: 'users#lists', as: 'user_lists'
  delete 'list/:id/recipe/(.:recipe_id)', to: 'recipe_lists#destroy', as: 'remove_recipe_from_list'
end
