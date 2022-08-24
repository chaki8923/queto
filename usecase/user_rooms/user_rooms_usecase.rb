require './usecase/user_rooms/user_rooms_query_servise'
require './domain/user_rooms/user_rooms_repository'

class UserRoomsUsecase
    def initialize(user_rooms_query_service,user_rooms_repository)
        @urqs = user_rooms_query_service
        @urr = user_rooms_repository
    end

    def insert(user_room_id,user_id,room_id)
        user_rooms,err = UserRoom.new(user_room_id,user_id,room_id)
        return err,nil unless err.nil?

        @urr.insert(user_rooms)

        [user_rooms,nil]
    end
    
    def get_user_rooms(user_id,room_id)
        @urqs.find_user_rooms
    end
    
    def update(user_room_id,user_id,room_id)
        user_rooms,err = UserRoom.new(user_room_id,user_id,room_id)
        return err,nil unless err.nil?
    
        @urr.update(user_rooms)
    
        [user_rooms,nil]
    end
end