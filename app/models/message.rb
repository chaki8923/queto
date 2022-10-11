class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates_presence_of :content

  def template
    # messageコントローラーからmessageとuser情報を渡してる。js側にテンプレートごと渡す。
    ApplicationController.renderer.render partial: "messages/message_old",
                                          locals: {
                                            message: self
                                          }
  end

  def template_young
    # messageコントローラーからmessageとuser情報を渡してる。js側にテンプレートごと渡す。
    ApplicationController.renderer.render partial: "messages/message_young",
                                          locals: {
                                            message: self
                                          }
  end
end
