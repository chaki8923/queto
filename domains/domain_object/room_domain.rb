
require './domains/value_object/room/room_name.rb'
require './domains/value_object/room/room_request_flg.rb'
require './domains/value_object/room/room_admin_user.rb'


class RoomDomain
    def create_instance(err,args)
 
        if err.nil?
            {name: args[:name].value,request_flg: args[:request_flg].value,admin_user: args[:admin_user].value}
        else
            {name: args[:name],request_flg: args[:request_flg],admin_user: args[:admin_user]}
        end
    end
end