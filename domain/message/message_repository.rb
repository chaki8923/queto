

class MessageRepository

    def initialize(db)
        @db = db
    end


    def insert(message)
        @db[:messages].insert(
            message_id: message.message_id.value,
            content: message.content.value,
            room_id: message.room_id.value,
            user_id: message.user_id.value,
            request_flg: message.request_flg.value,
            convert_old_message: message.convert_old_message.value,
            convert_young_message: message.convert_young_message.value,
            created_at: Sequel::CURRENT_TIMESTAMP,
            updated_at: Sequel::CURRENT_TIMESTAMP
        )
    end

    def update(message)
        @db[:messages].where(message_id: message.message_id.value).update(
            message_id: message.message_id.value,
            content: message.content.value,
            room_id: message.room_id.value,
            user_id: message.user_id.value,
            request_flg: message.request_flg.value,
            convert_old_message: message.convert_old_message.value,
            convert_young_message: message.convert_young_message.value,
            updated_at: Sequel::CURRENT_TIMESTAMP
        )
    end
    
    
    def update_old_message(message_id,new_message)
        @db[:message].where(message_id: message.id).update(
            convert_old_message: new_message,
            updated_at: Sequel::CURRENT_TIMESTAMP
        )
    end

    def update_young_message(message_id,new_message)
        @db[:message].where(message_id: message.id).update(
            convert_young_message: new_message,
            updated_at: Sequel::CURRENT_TIMESTAMP
        )
    end

    def message_convert(word,message,user)
        if message.content.include?(word.term) && user.adult_flg == false # 若者が発した言葉のみ変換。おじさんの背伸びは変換しないであげる
            new_message = message.convert_old_message.gsub!(word.conversion, word.term)
            update_young_message(message.id,new_message )
        elsif message.content.include?(word.conversion) && user.adult_flg == true  # おじさんが発信したら若者言葉に変換。若者の優しさは変換しない
            new_message = message.convert_old_message.gsub!(word.conversion, word.term)
            update_old_message(message.id, word)
        end
    end

end