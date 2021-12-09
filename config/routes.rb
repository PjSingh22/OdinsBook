Rails.application.routes.draw do
  get 'friends/index'
  get 'friends/destroy'
  resources :friend_requests do
    member do
      post :accept
    end
  end
  devise_for :users
  resources :user_posts
  match 'users/:id' => 'users#show', :as => :user, :via => :get

  root 'user_posts#index'
end
