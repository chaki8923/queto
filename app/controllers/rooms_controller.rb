class RoomsController < ApplicationController
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
    if  Room.exists?(id: params[:id])
      @room = @current_user.rooms.find(params[:id])
      @room.update!(request_flg: false)
      @messages = @room.messages.all.order(created_at: 'ASC')
      # @messages = @messages.room_requests.all
      @message = @room.messages.build
      @user = User.find_by(id: params[:user_id])
      @current_user_adult = @user.adult_flg
    else
      redirect_to user_rooms_path,notice: '管理者が部屋を削除しました。'
    end

  end


  def create
    @room = Room.new(room_params)
    if @room.save
      user_room = UserRoom.create(user_id: params[:user_id], room_id: @room.id)
      redirect_to user_rooms_path(@current_user)
    else
      render 'new'
    end

  end

  def destroy

    @room = @current_user.rooms.find(params[:id])
    if @room.present?
      @room.destroy
      redirect_to user_rooms_path(@current_user),notice: '削除しました'
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :admin_user)
  end
end
