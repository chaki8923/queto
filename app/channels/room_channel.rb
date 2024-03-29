class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    @user = User.find_by(id: params[:user_id])
    reject if @user.nil?
    @room = @user.rooms.find_by(id: params[:id])
    puts @room
    if @room.nil?
      @rooms = Room.all
      stream_for(@rooms)
    end
    puts "サブスク"
    puts current_user.name
    stream_for(@room)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
