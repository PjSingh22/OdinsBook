Rails.application.routes.draw do
  resources :comments
  get 'friends/index'
  get 'friends/destroy'
  resources :friends, only: [:index, :create, :destroy]
  resources :friend_requests do
    member do
      post :accept
      post :reject
    end
  end
  resources :user_posts do
    resources :comments
    resources :likes
  end
  devise_for :users
  resources :user_posts
  match 'users/:id' => 'users#show', :as => :user, :via => :get
  match 'pending_requests' => 'friend_requests#index', :as => :pending_requests, :via => :get
  root 'user_posts#index'
end
