require './usecase/message/message_query_servise'
require './usecase/user/user_usecase'
require './domain/message/message_repository'



class MessageUserCase
    def initialize(message_query_service,user_usecase,message_repository)
        @mqs = message_query_service
        @mr = message_repository
        @uu = user_usecase
    end

    def insert_message(message_id,content,user_id,room_id,request_flg,convert_old_message,convert_young_message)
        message,err = Message.new(message_id,content,user_id,room_id,request_flg,convert_old_message,convert_young_message)
        return nil,err unless err.nil?
        @mr.insert(message)

        [message,nil]
    end
    
    def update_message(message_id,content,user_id,room_id,request_flg,convert_old_message,convert_young_message)
        message,err = Message.new(message_id,content,user_id,room_id,request_flg,convert_old_message,convert_young_message)
        return nil,err unless err.nil?
        @mr.update(message)
    
        [message,nil]

    end


    def get_messages(room_id)
        @mqs.find_by_room(room_id)
    end

    def convert_message(message)
        words = @mqs.get_word_all
        @mqs.maping_word(words,message)
    end



end