class MessagesController < ApplicationController
  protect_from_forgery

  def create_young_message(message, word)
    new_message = message.convert_young_message.gsub!(word.term, word.conversion)
    message.update!(convert_young_message: new_message)
  end

  def create_old_message(message, word)
    new_message = message.convert_old_message.gsub!(word.conversion, word.term)
    message.update!(convert_old_message: new_message)
  end

  def create
    @message = Message.create!(message_params)
    @message.update!(convert_old_message: message_params['content'], convert_young_message: message_params['content'])
    @room = Room.find_by(id: message_params[:room_id])
    @words = Word.all

     
    @words.map do |word|
      if @message.content.include?(word.term) && @current_user.adult_flg == false # 若者が発した言葉のみ変換。おじさんの背伸びは変換しないであげる
        create_young_message(@message, word)
      elsif @message.content.include?(word.conversion) && @current_user.adult_flg == true  # おじさんが発信したら若者言葉に変換。若者の優しさは変換しない
        create_old_message(@message, word)
      end
    end

    # js側にデータ渡してる
    RoomChannel.broadcast_to(@room, message_id: @message.user_id, user: @user, message_old: @message.template,message_young: @message.template_young)
  end

  # 参加リクエスト
  def join
    @message = Message.create!(content: params['content'], room_id: params['room_id'], user_id: @current_user.id,
      request_flg: params['request_flg'])
      @room = Room.find_by(id: params['room_id'])
      @room.update!(request_flg: true)
      RoomRequest.find_or_create_by(user_id: @current_user.id, room_id: params['room_id'])
      RoomChannel.broadcast_to(@room, message_old: @message.template,message_young: @message.template_young)
    end
    
  # 参加リクエストの許可
  def permission
    @current_room = Room.find_by(id: params['room_id'])
    message = Message.where(user_id: params['user_id'], room_id: params['room_id']).where.not(request_flg: nil).first
    @name = User.find_by(id: params['push_user']).name
    if Room.find_or_create_by(id: @current_room.id, name: @current_room.name)
      message.update(convert_old_message: "#{@name}さん承認ありがとう！", convert_young_message: "#{@name}さん承認ありがとう！", request_flg: nil)
      UserRoom.find_or_create_by(user_id: params['user_id'], room_id: params['room_id'])
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :room_id, :user_id, :request_flg, :push_user, :convert_message)
  end
end
