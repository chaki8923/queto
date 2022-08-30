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



class RoomsController < ApplicationController
  
  before_action :dependency_injection,:dependency_injection_room,:dependency_injection_message
  
  def new
    @room = Room.new
  end

  def index
    @rooms = Room.all
    @room_requests = RoomRequest.find_by(user_id: @current_user.id)
    @request_flg = true
    @request_flg = false if @room_requests.nil?
  end

  def show
    @room = @rcs.find(@current_user,params[:id])
    @room.update!(request_flg: false)
    @messages = @mcs.get_all(@room)
    @message = @mcs.build(@room)
    @user = User.find_by(id: params[:user_id])
    @user = @ucs.find(params[:user_id])
    @current_user_adult = @user.adult_flg

  end

  def create
    @room = @rcs.new(room_params)
    if @rcs.save(@room)
      user_room = UserRoom.create(user_id: params[:user_id], room_id: @room.id)
      redirect_to user_rooms_path(@current_user)
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :admin_user,:request_flg)
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


end
