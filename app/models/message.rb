class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates_presence_of :content

  def template
    #messageコントローラーからmessageとuser情報を渡してる。
    ApplicationController.renderer.render partial: 'messages/message', locals: { message: self,current_user: user}
  end
end
