Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #トップ画面
  root 'homes#top'

  #デバイス
  devise_for :users
  #ユーザー
  resources :users, only: [:show, :edit, :update, :destroy]
  get "users/unsubscribe" => "users#unsubscribe", as: :unsubscribe

  #投稿
  resources :posts, only: [:index, :create, :show, :edit, :update, :destroy] do
    #コメント
    resources :post_comments, only: [:create, :destroy]
    #いいね
    resource :favorites, only: [:create, :destroy]
  end
  get "posts/follow" => "posts#follow", as: :follower_posts

  #検索
  get '/search' => "searchs#search"

  #フォロー
  post 'follow/:id' => 'follows#follow', as: 'follow'
  post 'unfollow/:id' => 'follows#unfollow', as: 'unfollow'
  get 'follower/:id' => 'follows#follower', as: 'follower'
  get 'followed/:id' => 'follows#followed', as: 'followed'

end
