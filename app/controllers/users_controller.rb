class UsersController < ApplicationController

  #投稿者ページ
  def show
    @user = User.find(params[:id])
    @users = User.where.not(id: current_user.id)
    @posts = Post.all
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

  private
  def user_params
    params.require(:user).permit(:name, :users_name, :image_id, :introduction )
  end

end
