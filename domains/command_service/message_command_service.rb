
require './domains/domain_object/message_domain.rb'
require './domains/aggregate/message_aggregate.rb'
require './infras/write_repository/message_write_repository.rb'
require './infras/read_repository/message_read_repository.rb'


class MessageCommandService
    def initialize(message_domain,message_aggregate,message_write_repository,message_read_repository)
        @md = message_domain
        @ma = message_aggregate
        @mwr = message_write_repository
        @mrr = message_read_repository
    end

    def new(params)
        content,err = @ma.content(params[:content])
        user_id,err = @ma.user_id(params[:user_id].to_i)
        room_id,err = @ma.room_id(params[:room_id].to_i)
        admin_user,err = @ma.admin_user(params[:admin_user].to_i)
        args = {contnet: content,user_id: user_id,room_id: room_id,admin_user: admin_user}
        # errがある時点で完全なインスタンスは作成されないようにする
        room = Room.new(@rd.create_instance(err,args))
        
    end

    def build(room)
        @md.build(room)
    end

    def create
    end


    def get_all(room)
        @mrr.get_all(room)
    end
end