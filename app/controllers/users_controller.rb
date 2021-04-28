class UsersController < ApplicationController
   before_action :authenticate_user!, except: [:show]

  #投稿者ページ
  def show
    if user_signed_in?
    @users = User.where.not(id: current_user.id).page(params[:page]).per(10)
    @user=User.find(params[:id])
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
    else
      @user=User.find(params[:id])
      @users = User.all.page(params[:page]).per(10)
    end
  end

  #マイページ編集
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  # 退会確認画面
  def unsubscribe
    @user = User.find(params[:id])
  end

  #退会
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :root
  end

  #フォロー
  def following
    @user = User.find(params[:id])
    @users = @user.following_user
  end

  #アンフォロー
  def followers
    @user = User.find(params[:id])
    @users = @user.follower_user
  end

  private
  def user_params
    params.require(:user).permit(:name, :users_name, :image, :introduction )
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
