

class RoomWriteRepository
    def initialize(room_aggregate)
        @room_aggregate = room_aggregate
    end

    def save
        room = Room.new
        room.name = room_aggregate.name(value)
        room.request_flg = room_aggregate.request_flg(value)
        room.admin_user = room_aggregate.admin_user(value)

        room.save
    end

    def update
    end
end