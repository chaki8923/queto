require 'uri'
require 'securerandom'
Dir['./domain/value_object/*.rb'].sort.each { |file| require file }

class Message
    attr_reader :message_id,:content,:user_id,:room_id,:request_flg,:convert_old_message,:convert_young_message

    def initialize(message_id,content,user_id,room_id,request_flg,convert_old_message,convert_young_message)
        @content = content
        @user_id = user_id
        @room_id = room_id
        @request_flg = request_flg
        @convert_old_message = convert_old_message
        @convert_young_message = convert_young_message
    end

    def self.new(message_id,content,user_id,room_id,request_flg,convert_old_message,convert_young_message)

        message_id,err = UuId.new(message_id)
        return nil,err unless err.nil?

        content,err = MessageContent.new(content)
        return nil,err unless err.nil?

        user_id,err = UuId.new(user_id)
        return nil,err unless err.nil?

        room_id,err = UuId.new(room_id)
        return nil,err unless err.nil?

        request_flg,err = RoomRequestFlg.new(request_flg)
        return nil,err unless err.nil?

        convert_old_message,err = MessageContent.new(convert_old_message)
        return nil,err unless err.nil?
        
        convert_young_message,err = MessageContent.new(convert_young_message)
        return nil,err unless err.nil?

        super(message_id,content,user_id,room_id,request_flg,convert_old_message,convert_young_message)
    end

    def self.create(content,request_flg,convert_old_message,convert_young_message)
        new(SecureRandom.uuid,content,SecureRandom.uuid,SecureRandom.uuid,request_flg,convert_old_message,convert_young_message)
    end

end