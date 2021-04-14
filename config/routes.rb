Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #トップ画面
  root 'homes#top'

  #デバイス
  devise_for :users
  #ユーザー
  resources :users
  get "user/follow" => "user#follow"

  #投稿
  resources :posts

  #コメント
  resources :post_comments

  #いいね
  resources :favorites

  #フォロー
  resources :follows
end