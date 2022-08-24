require './usecase/room_request/request_query_servise'
require './domain/room_request/request_repository'


class RequestUsecase

    def initialize(request_query_service,request_repository)
        @rqs = request_query_service
        @rr = request_repository
    end

    def insert(request_id,user_id,room_id)
        room_request,err = RoomRequest.new(request_id,user_id,room_id)
        return nil,err unless err,nil?

        @rr.insert(room_request)

        [room_request,err]
    end

    def update(request_id,user_id,room_id)
        room_request,err = RoomRequest.new(request_id,user_id,room_id)
        return nil,err unless err,nil?

        @rr.update(room_request)

        [room_request,err]
    end

    def get_room_request(room_id)
        @rqs.find_by_room_id(room_id)
    end

    
end