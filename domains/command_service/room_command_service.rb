require './domains/domain_object/room_domain.rb'

class RoomCommandService
    def initialize(room_domain,room_aggregate,room_write_repository)
        @ud = room_domain
        @ua = room_aggregate
        @uwr = room_write_repository
    end

    def new_instans

    end

    def create

    end

    def show
    end
end