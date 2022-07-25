class RoomsController < ApplicationController
  def new
    @room = Room.new
  end

  def index
    @rooms = Room.all
  end

  def show
    @room = @current_user.rooms.find(params[:id])
    @messages = @room.messages.all
    @message = @room.messages.build

   
  end

  def get_messages
    @room = @current_user.rooms.find(params[:id])
    @messages = @room.messages.all

    if @messages.present?
      messages_array = @messages.map do |message|
        {
          id:message.id,
          user_id:message.user_id,
          room_id:message.room_id,
          content:message.content,
          created_at:message.created_at
        }
      end
      render json:  messages_array,status: 200
    else
      render json:{messages:'まだメッセージはありません'},status: 400
    end

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
