require 'sequel'
require '/domain/message/*.rb'
require '/usecase/user/user_usecace'

class MessageQueryService
    def initialize(db,message_repository,user_usecase)
        @mr = message_repository
        @uu = user_usecase
        @db = db
    end

     
    def find_by_room(room_id)
        @db[:messages].where(:room_id room_id).order(:created_at)
    end

    def get_word_all
        @db[:words].all
    end

    def maping_word(words,message)
        user = @uu.get_user(message_id)
        words.map do |word|
            @mr.message_convert(word,message,user)
        end
    end



end