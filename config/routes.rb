Rails.application.routes.draw do
  root "auth#top"

  get "words/new"
  get "words/index"
  get "words/:id/edit", to: "words#edit"
  patch "words/:id/edit", to: "words#update"
  post "words/new", to: "words#create"

  resources :messages, only: [:create]
  post "/join_us", to: "messages#join"
  post "/permission", to: "messages#permission"
  resources :words

  resources :users, only: [] do
    resources :rooms, only: %i[new index show create destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "get_judgement", to: "old_judgements#get_judgement"
  post "create_judgement", to: "old_judgements#create_judgement"
  #vue側でuser_id取得用
  get "get_user", to: "auth#get_user"
  get "get_message/:user_id/:id", to: "rooms#get_messages"

  get "/signup", to: "auth#new"
  post "/signup", to: "auth#create"
  get "/auth/:id/avatar", to: "auth#avatar"
  post "/auth/:id/avatar", to: "auth#update_avatar"
  patch "/auth/:id/edit", to: "auth#update"
  get "/home", to: "auth#index"

  get "login", to: "session#new"
  delete "logout", to: "session#destroy"
  post "login", to: "session#create"

  get "/aws_signed", to: "auth#upload"

  # root to: 'auth#home'
  resources :auth
  resources :users
  resources :old_judgements
end
