

class RequestQueryService
    def initialize(db)
        @db = db
    end

    def find_by_room_id(room_id)
        @db[:room_requests].where(room_id: room_id,deleted_at:,nil)
    end

end