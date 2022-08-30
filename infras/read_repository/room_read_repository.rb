require './domains/read_repositable/room_read_repositable.rb'


class RoomReadRepository < RoomReadRepositable

    def find(current_user,id)
        current_user.rooms.find(id)
    end


    def get
    end
end