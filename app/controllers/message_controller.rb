class MessageController < ApplicationController
  def create
    @message = Message.create!(message_params)
  end
  private
    def message_params
      params.require(:message).permit(:content, :room_id, :user_id)
    end
end
