

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

    def find_by_room(room_id)
        @db[:messages].where(:room_id room_id).order(:created_at)
    end

    


end