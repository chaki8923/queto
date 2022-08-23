


class RequestRepository

    def initialize(db)
        @db = db
    end

    def insert(room_request)
        @db[:room_requests].insert(
            request_id: room_request.request_id.value,
            user_id: room_request.user_id.value,
            room_id: room_request.room_id.value,
            created_at: Sequel::CURRENT_TIMESTAMP,
            updated_at: Sequel::CURRENT_TIMESTAMP
        )
    end


    def update(room_request)
        @db[:room_request].where(
            room_id: room_request.room_id.value,
            user_id: room_request.user_id.value
        ).update(
            request_id: room_request.request_id.value,
            user_id: room_request.user_id.value,
            room_id: room_request.room_id.value,
            updated_at: Sequel::CURRENT_TIMESTAMP
        )
    end
end