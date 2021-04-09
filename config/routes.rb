Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #トップ画面
  root 'homes#top'
  get 'homes/about' => 'homes#about'

  #デバイス
  devise_for :users

  #ユーザー
  resources :user

  #投稿
  resources :post

  #コメント
  resources :post_comment
end
