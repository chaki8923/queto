require './domains/domain_object/room_domain.rb'
require './domains/aggregate/room_aggregate.rb'
require './infras/write_repository/room_write_repository.rb'
require './infras/read_repository/room_read_repository.rb'

class RoomCommandService

    def initialize(room_domain,room_aggregate,room_write_repository,room_read_repository)
        @rd = room_domain
        @ra = room_aggregate
        @rwr = room_write_repository
        @rrr = room_read_repository
    end

    def new(params)
        room_name,err = @ra.name(params[:name])
        request_flg,err = @ra.room_request(params[:request_flg].to_i)
        admin_user,err = @ra.admin_user(params[:admin_user].to_i)
        args = {name: room_name,request_flg: request_flg,admin_user: admin_user}
        # errがある時点で完全なインスタンスは作成されないようにする
        room = Room.new(@rd.create_instance(err,args))
        
    end

    def save(room)
        @rwr.save(room)
    end

    def find(current_user,id)
        @rrr.find(current_user,id)
    end

    def create

    end

    def show

    end

    def update

    end
end