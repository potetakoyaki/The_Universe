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

    def show
      @post = Post.find(params[:id])
      @user = @post.user
      @users = User.where.not(id: current_user.id)
      @post_comment = PostComment.new
    end

    #新規投稿
    def create
      @posts = Post.all
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      if @post.save
      else
        respond_to do |format|
          format.html { render :new }
          format.js { render :errors }
        end
      end
    end

    #投稿編集
    def edit
      @post = Post.find(params[:id])
      @user = @post.user
      @users = User.where.not(id: current_user.id)
    end

    def update
      @post= Post.find(params[:id])
      if @post.update(post_params)
        redirect_to post_path(@post)
      else
        @post = Post.find(params[:id])
        render :edit
      end
    end

    #投稿削除
    def destroy
      @posts = Post.all
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to user_path(@post.user)
    end

    #フォロー先の投稿表示
    def timeline
      @users = User.where.not(id: current_user.id)
      @post = Post.new(params[:id])
      @post_all = Post.all
      @user = User.find(current_user.id)
      @follow_users = @user.following_user
      @posts = @post_all.where(user_id: @follow_users).order("created_at DESC")
    end


    private
    def post_params
      params.require(:post).permit(:title, :body, :image)
    end
end
