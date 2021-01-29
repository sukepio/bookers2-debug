Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => 'homes#about'
  get '/map_request', to: 'homes#map', as: 'map_request'
  devise_for :users, :controllers => {
    :sessions => 'users/sessions',
    :registrations => 'users/registrations',
  }

  resources :users,only: [:show,:index,:edit,:update] do
    member do
      get :following, :follower
    end
    collection do
      post :confirm
    end
  end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  post "create/:id" => "relationships#create", as: 'follow'
  post "destroy/:id" => "relationships#destroy", as: 'unfollow'

  get "search" => "searches#search"

  get "chat/:id" => "chats#show", as: 'chat'
  resources :chats, only: [:create]

end