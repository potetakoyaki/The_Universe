class FavoritesController < ApplicationController
    def create
      @post = Post.find(params[:post_id])
      favorite = current_user.favorites.build(post_id: @post.id)
      favorite.save
    end

    def destroy
      @post = Post.find(params[:post_id])
      favorite = current_user.favorites.find_by(post_id: @post.id)
      favorite.destroy
    end
end
