class PostsController < ApplicationController
    before_action :authenticate_user!,except: [:index,:show]
    #投稿一覧
    def index
      @posts = Post.all
      @post = Post.new
      if user_signed_in?
        @users = User.where.not(id: current_user.id).page(params[:page]).per(5)
      else
        @users = User.all.page(params[:page]).per(4)
      end
    end


    def show
    @post = Post.find(params[:id])
    @user = @post.user
    if user_signed_in?
      @post_comment = PostComment.new
      @currentUserEntry=Entry.where(user_id: current_user.id)
      @userEntry=Entry.where(user_id: @user.id)
      if @user.id == current_user.id
      else
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            if cu.room_id == u.room_id then
              @isRoom = true
              @roomId = cu.room_id
            end
          end
        end
        if @isRoom
        else
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
    end

    #新規投稿
    def create
      @posts = Post.all
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      if @post.save
        tags = Vision.get_image_data(@post.image)
        tags.each do |tag|
        @post.tags.create(name: tag)
        end
        redirect_to posts_path
      else
        @users = User.where.not(id: current_user.id).page(params[:page]).per(5)
        render :index
      end
    end

    #投稿編集
    def edit
      @post = Post.find(params[:id])
      @user = @post.user
    end

    def update
      @post= Post.find(params[:id])
      if @post.update(post_params)
        tags = Vision.get_image_data(@post.image)
        tags.each do |tag|
        @post.tags.create(name: tag)
        end
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
      @users = User.where.not(id: current_user.id).page(params[:page]).per(5)
      @post = Post.new(params[:id])
      @post_all = Post.all
      @user = User.find(current_user.id)
      @follow_users = @user.following_user
      @posts = @post_all.where(user_id: @follow_users)
    end

    private
    def post_params
      params.require(:post).permit(:body, :image)
    end
end
