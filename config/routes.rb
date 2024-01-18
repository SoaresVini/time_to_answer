Rails.application.routes.draw do
  namespace :users_backoffice do
    get 'welcome/index'
  end
  devise_for :users
  namespace :site do
    get 'welcome/index'
  end
  namespace :admins_backoffice do
    get 'welcome/index'
  end
  devise_for :admins

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'inicio', to: 'site/welcome#index'

  root to: "site/welcome#index"

end
