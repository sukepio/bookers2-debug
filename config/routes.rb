Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users, :controllers => {
    :sessions => 'users/sessions',
    :registrations => 'users/registrations',
  }
  
  resources :users,only: [:show,:index,:edit,:update] do 
    member do 
      get :following, :follower
    end
  end
  
  resources :books do 
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  post "create/:id" => "relationships#create", as: 'follow'
  post "destroy/:id" => "relationships#destroy", as: 'unfollow'
  
  get "search" => "searches#search"
  
end