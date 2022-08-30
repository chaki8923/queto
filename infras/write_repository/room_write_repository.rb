require './domains/write_repositable/room_write_repositable.rb'

class RoomWriteRepository < RoomWriteRepositable

    def save(room)
        room.save
    end

    # def update
    # end
end