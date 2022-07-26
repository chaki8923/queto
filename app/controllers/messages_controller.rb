class MessagesController < ApplicationController

  def create

    @message = Message.create!(message_params)
    @room = Room.find_by(id: message_params[:room_id])
    @user = @current_user
    RoomChannel.broadcast_to(@room, user:@user,message: @message.template)
  end
  
  def join
    @message = Message.create!(content: params['content'],room_id: params['room_id'],user_id: @current_user.id)
    @room = Room.find_by(id: params['room_id'])
    RoomRequest.find_or_create_by(user_id: @current_user.id,room_id: params['room_id'])

    RoomChannel.broadcast_to(@room, user:@user,message: @message.template)
  end

  private
    def message_params
      params.require(:message).permit(:content, :room_id, :user_id)
    end

end
