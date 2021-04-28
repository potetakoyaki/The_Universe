class FollowsController < ApplicationController
  before_action :authenticate_user!, except: [:follower,:followed]
  def follow
    current_user.follow(params[:id])
    redirect_back(fallback_location: root_path)
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_back(fallback_location: root_path)
  end

  def follower
    @user = User.find(params[:id])
    @users = @user.following_user
    if user_signed_in?
      @allusers = User.where.not(id: current_user.id)
    else
      @allusers = User.all
    end
  end

  def followed
    @user = User.find(params[:id])
    @users = @user.follower_user
    if user_signed_in?
      @allusers = User.where.not(id: current_user.id)
    else
      @allusers = User.all
    end
  end
end