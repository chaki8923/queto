

class UserRoomsQueryService
    def initialize(db)
        @db = db
    end

    def find_user_rooms(user_id,room_id)
        @db[:user_rooms].where(user_id: user_id,room_id: room_id).all
    end
end