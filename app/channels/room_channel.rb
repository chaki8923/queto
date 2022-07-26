class RoomChannel < ApplicationCable::Channel

  def subscribed
    puts 'サブスク！！！！！'
    # stream_from "some_channel"
    @user = User.find_by(id: params[:user_id])
    puts 'ユーザーOK'
    puts @user
    reject if @user.nil?
    @room = @user.rooms.find_by(id: params[:id])
    puts 'ルームOK'
    puts @room
    reject if @room.nil?
    stream_for(@room)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
