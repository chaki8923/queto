

class MessageDomain


    def  create_instance(err,args)

        if err.nil?
            {content: args[:content].value, user_id: args[:user_id].value, room_id: args[:room_id].value}
        else
            {content: args[:content],user_id: args[:user_id],room_id: args[:room_id]}
        end
    end

    def build(room)
        room.messages.build
    end


    

    def conect_chanel(chanel)
    end

end