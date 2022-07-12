Rails.application.routes.draw do
  get 'words/new'
  post 'words/new', to: 'words#create'
  get 'rooms/index'
  get 'rooms/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get    '/signup',   to: 'auth#new'
  post   '/signup',   to: 'auth#create'
  get    '/home',   to: 'auth#index'
  get    'login',   to: 'session#new'

  post   'login',   to: 'session#create'
  # root to: 'auth#home'  
  resources :users
end
