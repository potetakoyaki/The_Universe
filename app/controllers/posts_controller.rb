class PostsController < ApplicationController

    #投稿一覧
    def index
      @posts = Post.all
      @post = Post.new
      @users = User.where.not(id: current_user.id)
    end

    #新規投稿
    def create
      @posts = Post.all
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      if @post.save
      else
        render :index
      end
    end

    #投稿編集
    def edit
    end

    def update
    end

    #投稿削除
    def destroy
      @posts = Post.all
      @post = Post.find(params[:id])
      @post.destroy
    end

    #フォロー先の投稿表示
    def follow
    end

    
    private
    def post_params
      params.require(:post).permit(:title, :body, :image)
    end
end
