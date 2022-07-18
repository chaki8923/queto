class RoomsController < ApplicationController
  def new
    @room =Room.new
  end

  def index
    @rooms = @current_user.rooms.all
  end

  def show
    @room = @current_user.rooms.find(params[:id])
    @messages = @room.messages.all
    @message = @room.messages.build
    puts 'message------'
    puts @message
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      user_room = UserRoom.create(user_id:params[:user_id],room_id:@room.id)
      redirect_to home_path, notice: '登録されました'
    else
    end
  end

  private
    def room_params
      params.require(:room).permit(:name)
    end

end
