

class RoomRepository

    def initialize(db)
        @db = db
    end

    def insert(room)
        @db[:rooms].insert(
            room_id: room.room_id.value,
            name: room.room_name.value,
            admin_user: room.admin_user.value,
            request_flg: room.request_flg.value
        )
    end

    # クエリ
    def find_by_all()
        @db[:rooms].where(deleted_at: nil).order(:created_at)
    end

    def delete(room)
        @db[:rooms].where(room_id: room.room_id.value).delete(
            deleted_at: Sequel::CURRENT_TIMESTAMP
        )
    end
end