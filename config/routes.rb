Rails.application.routes.draw do
  get 'friends/index'
  get 'friends/destroy'
  resources :friend_requests
  devise_for :users
  resources :user_posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'user_posts#index'
end
