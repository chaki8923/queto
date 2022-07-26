class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates_presence_of :content

  def template
    ApplicationController.renderer.render partial: 'messages/message', locals: { message: self }
  end
end
