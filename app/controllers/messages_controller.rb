require './domains/command_service/user_command_service.rb'
require './domains/domain_object/user_domain.rb'
require './domains/aggregate/user_aggregate.rb'
require './infras/write_repository/user_write_repository.rb'
require './infras/read_repository/user_read_repository.rb'

require './domains/command_service/room_command_service.rb'
require './domains/domain_object/room_domain.rb'
require './domains/aggregate/room_aggregate.rb'
require './infras/write_repository/room_write_repository.rb'
require './infras/read_repository/room_read_repository.rb'

require './domains/command_service/message_command_service.rb'
require './domains/domain_object/message_domain.rb'
require './domains/aggregate/message_aggregate.rb'
require './infras/read_repository/message_read_repository.rb'
require './infras/write_repository/message_write_repository.rb'

require './domains/command_service/word_command_service.rb'
require './domains/domain_object/word_domain.rb'
require './domains/aggregate/word_aggregate.rb'
require './infras/read_repository/word_read_repository.rb'
require './infras/write_repository/word_write_repository.rb'




class MessagesController < ApplicationController
  protect_from_forgery
  skip_before_action :adult_flg!
  before_action :dependency_injection,:dependency_injection_room,:dependency_injection_message,:dependency_injection_word

  
  def create

    @words = @wcs.get_all
    @message = @mcs.create(message_params)
    @mcs.update(@message)
    @room = @rcs.find(@current_user,message_params[:room_id])
    @mcs.map_to_update(@words,@message,@current_user)

    # js側にデータ渡してる
    RoomChannel.broadcast_to(@room, message_id: @message.user_id, user: @user, message_old: @message.template,message_young: @message.template_young)
  end

  # 参加リクエスト
  def join
    @message = Message.create!(content: params['content'], room_id: params['room_id'], user_id: @current_user.id,
      request_flg: params['request_flg'])
      @room = Room.find_by(id: params['room_id'])
      @room.update!(request_flg: 1)
      RoomRequest.find_or_create_by(user_id: @current_user.id, room_id: params['room_id'])
      RoomChannel.broadcast_to(@room, message_old: @message.template,message_young: @message.template_young)
  end
    
    # 参加リクエストの許可
    def permission

      if params['push_user'].to_i == @current_user.id
        
        @current_room = Room.find_by(id: params['room_id'])
        @message = Message.where(user_id: params['user_id'], room_id: params['room_id']).first
        
        @name = User.find_by(id: params['push_user']).name
        if Room.find_or_create_by(id: @current_room.id, name: @current_room.name)
          @message.update!(convert_old_message: "#{@name}さん承認ありがとう！", convert_young_message: "#{@name}さん承認ありがとう！", request_flg: nil)
          UserRoom.find_or_create_by(user_id: params['user_id'], room_id: params['room_id'])
          redirect_to user_room_path(@current_user,@current_room)
          RoomChannel.broadcast_to(@rooms ,request_id: params['user_id'])
      end
    else
      return
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :room_id, :user_id, :request_flg, :push_user, :convert_message)
  end


  def dependency_injection
    ud = UserDomain.new
    ua = UserAggregate.new
    uwr = UserWriteRepository.new
    urr = UserReadRepoistory.new
    @ucs = UserCommandService.new(ud,ua,uwr,urr)

  end

 
  def dependency_injection_room
    rd = RoomDomain.new
    ra = RoomAggregate.new
    rwr = RoomWriteRepository.new
    rrr = RoomReadRepository.new
    @rcs = RoomCommandService.new(rd,ra,rwr,rrr)

  end

  def dependency_injection_message
    md = MessageDomain.new
    ma = MessageAggregate.new
    mwr = MessageWriteRepository.new
    mrr = MessageReadRepository.new
    @mcs = MessageCommandService.new(md,ma,mwr,mrr)

  end
  def dependency_injection_word
    wd = MessageDomain.new
    wa = WordAggregate.new
    wwr = WordWriteRepository.new
    wrr = WordReadRepository.new
    @wcs = WordCommandService.new(wd,wa,wwr,wrr)

  end
end
