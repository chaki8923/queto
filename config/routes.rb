Rails.application.routes.draw do
  get 'messages/craete'
  get 'message/create'
  get 'words/new'
  get 'words/index'
  get 'words/:id/edit', to: 'words#edit'
  patch 'words/:id/edit', to: 'words#update'
  post 'words/new', to: 'words#create'

  resources :words

  resources :users, only: [] do
    resources :rooms, only: [:new,:index, :show,:create]
  end


  resources :messages

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #vue側でuser_id取得用
  get 'get_user', to: 'auth#get_user'
  get    '/signup',   to: 'auth#new'
  post   '/signup',   to: 'auth#create'
  get    '/auth/:id/avatar',     to: 'auth#avatar'
  post   '/auth/:id/avatar',     to: 'auth#update_avatar'
  patch  '/auth/:id/edit',   to: 'auth#update'
  get    '/home',     to: 'auth#index'

  get    'login',     to: 'session#new'
  delete 'logout',   to: 'session#destroy'
  post   'login',   to: 'session#create'


  # root to: 'auth#home'  
  resources :auth
  resources :users
end
