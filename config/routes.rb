Rails.application.routes.draw do
  get 'words/new'
  get 'words/index'
  get 'words/:id/edit', to: 'words#edit'
  patch 'words/:id/edit', to: 'words#update'
  post 'words/new', to: 'words#create'

  resources :words
  
  
  get 'rooms/index'
  get 'rooms/show'
  resources :rooms
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get    '/signup',   to: 'auth#new'
  post   '/signup',   to: 'auth#create'
  get    '/home',     to: 'auth#index'
  get    'login',     to: 'session#new'
  delete  'logout',   to: 'session#destroy'

  post   'login',   to: 'session#create'
  # root to: 'auth#home'  
  resources :auth
  resources :users
end
