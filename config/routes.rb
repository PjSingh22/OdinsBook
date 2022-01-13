Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  resources :comments
  get 'friends/index'
  get 'friends/destroy'
  resources :friends, only: [:index, :create, :destroy]
  resources :user_posts
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
  match 'users/:id' => 'users#show', :as => :user, :via => :get
  match 'pending_requests' => 'friend_requests#index', :as => :pending_requests, :via => :get
  get 'all_users' => 'users#all_other_users'
  get 'search_users' => 'users#search'
  # edit user profile
  # match 'users/edit/:id' => 'users#edit', :as => :edit_profile, :via => :get

  # match 'friends' => 'friends#index', :as => :friends, :via => :get

  root 'user_posts#index'
end
