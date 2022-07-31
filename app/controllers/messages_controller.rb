class MessagesController < ApplicationController
  protect_from_forgery
  def create

    @message = Message.create!(message_params)
    @room = Room.find_by(id: message_params[:room_id])
    @user = User.find_by(id: current_user.id)
    puts 'id----------!!!!'
    puts @message.user_id
    puts @message.content
    #js側にデータ渡してる
    RoomChannel.broadcast_to(@room,message_id: @message.user_id, user:@user,message: @message.template)

  end
  
  def join
    @message = Message.create!(content: params['content'],room_id: params['room_id'],user_id: @current_user.id,request_flg: params['request_flg'])
    @room = Room.find_by(id: params['room_id'])
    @room.update!(request_flg: true)
    RoomRequest.find_or_create_by(user_id: @current_user.id,room_id: params['room_id'])
    RoomChannel.broadcast_to(@room,message: @message.template)
    
  end
  
  def permission
    
    @current_room = Room.find_by(id: params['room_id'])
    message = Message.where(user_id: params['user_id'],room_id: params['room_id']).where.not(request_flg: nil).first
    puts 'ID!!!!!!'
    puts params
    @name = User.find_by(id: params['push_user']).name
    if Room.find_or_create_by(id: @current_room.id,name: @current_room.name)
      
      message.update(content: "#{@name}さん承認ありがとう！" ,request_flg: nil)
      UserRoom.find_or_create_by(user_id: params['user_id'],room_id: params['room_id'])
    end
  end

  private
    def message_params
      params.require(:message).permit(:content, :room_id, :user_id,:request_flg,:push_user)
    end

end
