Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get    '/signup',   to: 'auth#new'
  get    '/home',   to: 'auth#home'
  post   '/signup',   to: 'auth#create'

  resources :users
end
