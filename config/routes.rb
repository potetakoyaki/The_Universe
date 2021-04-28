Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #トップ画面
  root 'posts#index'

  #デバイス
  devise_for :users
  #ユーザー
  resources :users, only: [:show, :edit, :update, :destroy]
  get "users/:id/unsubscribe" => "users#unsubscribe", as: :unsubscribe

  #投稿
  get "posts/timeline" => "posts#timeline", as: :timeline
  resources :posts, only: [:index, :create, :show, :edit, :update, :destroy] do
    #コメント
    resources :post_comments, only: [:create, :destroy]
    #いいね
    resource :favorites, only: [:create, :destroy]
  end

  #DM
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]

  #検索
  get '/search' => "searchs#search"

  #フォロー
  post 'follow/:id' => 'follows#follow', as: 'follow'
  post 'unfollow/:id' => 'follows#unfollow', as: 'unfollow'
  get 'follower/:id' => 'follows#follower', as: 'follower'
  get 'followed/:id' => 'follows#followed', as: 'followed'

end
