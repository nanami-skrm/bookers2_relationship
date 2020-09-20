Rails.application.routes.draw do
  root :to => 'home#top'
  get 'home/about' => 'home#about'
  devise_for :users
  resources :users, only: [:show,:index,:edit,:update] do
  	member do
  		get 'following'
  		get 'follower'
  	end

  end
  resources :books

  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする

  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す




end
