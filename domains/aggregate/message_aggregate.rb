
require './domains/value_object/message/message_content.rb'
require './domains/value_object/message/user_id.rb'
require './domains/value_object/message/room_id.rb'


class MessageAggregate
    
    def content(value)
        puts 'aggregate!!!!!'
        content,err = MessageContent.new(value)
        if err.nil?
            content
        else
            value
        end
    end
    
    def user_id(value)
        puts 'aggregate!!!!!'

        user_id,err = UserId.new(value)
        puts value
        puts user_id
        if err.nil?
            puts user_id.value
            user_id
        else
            value
        end
    end
    
    def room_id(value)
        puts 'aggregate!!!!!'
        room_id,err = RoomId.new(value)
        if err.nil?
            room_id
        else
            value
        end
    end
end