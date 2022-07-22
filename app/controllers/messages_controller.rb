class MessagesController < ApplicationController

  def create
    @message = Message.create!(message_params)
  end

  def index
    puts 'パラメーター'
    puts params

  
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
    render json: messages_array,status: 200
  else
    render json:{messages:'まだメッセージはありません'},status: 400
  end
end

  private
    def message_params
      params.require(:message).permit(:content, :room_id, :user_id)
    end

end
