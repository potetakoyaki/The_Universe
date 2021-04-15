class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
  end
   
  def unsubscribe
    
  end
  
  def withdraw
    
  end
end
