Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get    '/signup',   to: 'auth#new'
  post   '/signup',   to: 'auth#create'
  get    'login',   to: 'session#new'
  post   'login',   to: 'session#create'
  root to: 'auth#home'  
  resources :users
end
