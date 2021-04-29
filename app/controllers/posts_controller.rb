class PostsController < ApplicationController
    before_action :authenticate_user!,except: [:index,:show]
    #投稿一覧
    def index
      @posts = Post.all
      @post = Post.new
      if user_signed_in?
        @users = User.where.not(id: current_user.id).page(params[:page]).per(10)
      else
        @users = User.all.page(params[:page]).per(10)
      end
    end

    def show
      @room = Room.find(params[:id])
    if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
      @entry = @entries.where.not(:user_id => current_user.id)
    else
      redirect_back(fallback_location: root_path)
    end
      @post = Post.find(params[:id])
      @user = @post.user
      if user_signed_in?
        @users = User.where.not(id: current_user.id).page(params[:page]).per(10)
        @post_comment = PostComment.new
      else
        @users = User.all.page(params[:page]).per(10)
      end
    end

    #新規投稿
    def create
      @posts = Post.all
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      unless @post.save
        @users = User.where.not(id: current_user.id).page(params[:page]).per(10)
        render 'error'
      end
    end

    #投稿編集
    def edit
      @post = Post.find(params[:id])
      @user = @post.user
      @users = User.where.not(id: current_user.id).page(params[:page]).per(10)
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
      @users = User.where.not(id: current_user.id).page(params[:page]).per(10)
      @post = Post.new(params[:id])
      @post_all = Post.all
      @user = User.find(current_user.id)
      @follow_users = @user.following_user
      @posts = @post_all.where(user_id: @follow_users).order("created_at DESC")
    end


    private
    def post_params
      params.require(:post).permit(:body, :image)
    end
end
