class RoomsController < ApplicationController
  def new
    @room = Room.new
  end

  def index
    @rooms = Room.all
    @room_requests = RoomRequest.find_by(user_id: @current_user.id)
    @request_flg = true
    if @room_requests.nil?
      @request_flg = false
    end
   
  end

  def show
    @room = @current_user.rooms.find(params[:id])
    @room.update!(request_flg: false)
    @messages = @room.messages.all.order(created_at: "ASC")
    # @messages = @messages.room_requests.all
    @message = @room.messages.build 
    puts 'showメソッド'
    
  end
  
  def create
    @room = Room.new(room_params)
    if @room.save
      user_room = UserRoom.create(user_id: params[:user_id],room_id: @room.id)
      redirect_to home_path, notice: '登録されました'
    else
    end
  end

  private
    def room_params
      params.require(:room).permit(:name,:admin_user)
    end

end
