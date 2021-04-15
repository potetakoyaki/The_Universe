Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #トップ画面
  root 'homes#top'

  #デバイス
  devise_for :users
  #ユーザー
  resources :users, only: [:show, :edit, :update]
  get "users/unsubscribe" => "users#unsubscribe", as: :unsubscribe
  patch "/users/withdraw" => "users#withdraw", as: :withdraw

  #投稿
  resources :posts, only: [:index, :create, :show, :edit, :update, :destroy] do
    #コメント
    resources :post_comments, only: [:create, :destroy]
    #いいね
    resource :favorites, only: [:create, :destroy]
  end
  get "posts/follow" => "posts#follow", as: :follow

  #フォロー
  resources :follows

end
