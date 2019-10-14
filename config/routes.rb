Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    root to: 'recipes#index'

    resources :recipes, only: %i[index show new create edit update]
    resources :recipe_types, only: %i[index show new create edit update destroy]
    resources :lists, only: %i[show new create]
    resources :cuisines, only: %i[index show new create edit update destroy]
    resources :recipe_lists, only: %i[create]
    resources :users, only: %i[show]

    get 'search', to: 'pages#search'
    get 'admin_area', to: 'users#admin_area'
    get 'about', to: 'pages#about'
    get 'api_doc', to: 'pages#api_doc'

    get 'user/:id/lists', to: 'users#lists', as: 'user_lists'
    delete 'list/:id/recipe/(.:recipe_id)', to: 'recipe_lists#destroy', as: 'remove_recipe_from_list'

    get 'recipe/all', to: 'recipes#all', as: 'all_recipes'
    get 'user/my_recipes', to: 'users#my_recipes', as: 'my_recipes'
    get 'pending_recipes', to: 'recipes#pending_line', as: 'pending_recipes'
    get 'recipe/:id/reject', to: 'users#reject_recipe', as: 'reject_recipe'
    get 'recipe/:id/accept', to: 'users#accept_recipe', as: 'accept_recipe'

  end

  namespace :api do
    namespace :v1 do
      resources :recipes, only: %i[index show create destroy]
      post 'recipe/:id/rejected', to: 'users#reject_recipe', as: 'reject_recipe'
      post 'recipe/:id/accepted', to: 'users#accept_recipe', as: 'accept_recipe'
      resources :recipe_types, only: %i[show create]
    end
  end
end
