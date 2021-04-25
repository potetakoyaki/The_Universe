class RoomsController < ApplicationController
  before_action :authenticate_user!
  def create
    @room = Room.create
    @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

  def show
    @room = Room.find(params[:id])
    @users = User.where.not(id: current_user.id)
    if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
      @entry = @entries.where.not(:user_id => current_user.id)
    else
      redirect_back(fallback_location: root_path)
    end
    @currentEntries = current_user.entries
    myRoomIds = []
    @currentEntries.each do |entry|
      myRoomIds << entry.room.id
    end
    @users = User.where.not(id: current_user.id)
    @anotherEntries = Entry.where(room_id: myRoomIds).where.not(:user_id => current_user.id)
  end

  def index
    @currentEntries = current_user.entries
    myRoomIds = []
    @currentEntries.each do |entry|
      myRoomIds << entry.room.id
    end
    @users = User.where.not(id: current_user.id)
    @anotherEntries = Entry.where(room_id: myRoomIds).where.not(:user_id => current_user.id)
    @user = User.where(:user_id => current_user.id)
  end
end