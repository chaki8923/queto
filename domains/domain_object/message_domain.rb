

class MessageDomain


    def  new(err,args)
        
        if err.nil?
            {content: args[:content].value,user_id: args[:user_id].value,room_id: args[:room_id].value,admin_user: args[:admin_user].value}
        else
            {content: args[:content],user_id: args[:user_id],room_id: args[:room_id],admin_user: args[:admin_user]}

        end
    end

    def build(room)
        room.messages.build
    end
end