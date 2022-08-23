require '/usecase/message/message_query_servise'
require '/usecase/user/user_usecase'
require '/domain/message/message_repository'



class MessageUserCase
    def initialize(message_query_servise,user_usecase,message_repository)
        @mqs = message_query_servise
        @mr = message_repository
        @uu = user_usecase
    end

    def insert_message(message)
        @mr.insert(message)
    end

    def get_messages(room_id)
        messages = @mqs.find_by_room(room_id)
        [messages,nil]
    end

    def convert_message(message)
        words = @mqs.get_word_all
        @mqs.maping_word(words,message)
    end



end