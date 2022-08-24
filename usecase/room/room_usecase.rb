require './domain/room/room_repositpry'
require './usecase/room/room_query_servise'

class RoomUsecase
    def initialize(room_repositpry,room_usecase)
        @rr = room_repositpry
        @rqs = room_query_servise
    end

    def insert(message_id,room_id,room_name,admin_user,request_flg)
        room,err = Room.new(message_id,room_id,room_name,admin_user,request_flg)
        return nil,err unless err.nil?

        @rr(room)

        [room,nil]
    end

    def get_all
        @rqs.find_by_all
    end


    def delete(room_id)
        @rr.delete(room_id)
    end
end