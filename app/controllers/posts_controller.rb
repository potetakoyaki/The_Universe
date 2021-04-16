class PostsController < ApplicationController

    #投稿一覧
    def index
      @posts = Post.all
      @post = Post.new
      if user_signed_in?
        @users = User.where.not(id: current_user.id)
      else
        @users = User.all
      end
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
      @post.find(params[:id])
    end

    def update
      @post.find(params[:id])
      if @post.update(post_params)
        redirect_to post_path(@post)
      else
        render :edit
      end
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
