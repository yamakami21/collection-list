Rails.application.routes.draw do

  get 'sessions/new'

  root to: 'static_pages#home'
  get     'signup', to: 'users#new'
  get     'login' , to: 'sessions#new'
  post    'login' , to: 'sessions#create'
  delete  'logout', to: 'sessions#destroy'
  
  resources :users do
    member do
      get :followings
      get :followers
      get :likings
    end
  end
  # resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :items
  resources :likes, only: [:create, :destroy]

  
end
