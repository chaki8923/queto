

class UserRoomRepository

    def initialize(db)
        @db = db
    end

    def insert(user_room)
        @db[:user_rooms].insert(
            user_room_id: user_room.user_room_id.value,
            user_id: user_room.user_id.value,
            room_id: user_room.room_id.value,
            created_at: Sequel::CURRENT_TIMESTAMP,
            updated_at: Sequel::CURRENT_TIMESTAMP
        )
    end

    def update(user_room_id)
        @db[:user_rooms].where(user_room_id: user_room_id,deleted_at: nil).update(
            user_id: user_room.user_id.value,
            room_id: user_room.room_id.value,
            updated_at: Sequel::CURRENT_TIMESTAMP
        )
    end
end