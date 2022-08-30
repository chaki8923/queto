Dir['./domain/value_object/message/*.rb'].sort.each { |file| require file }


class MessageAggregate

    def content(value)
        name,err = MessageContent.new(value)
        if err.nil?
            name
        else
            value
        end
    end

    def room_id(value)
        room_id,err = RoomId.new(value)
        puts err
        if err.nil?
            room_id
        else
            value
        end
    end

    def user_id(value)

        user_id,err = UserIdr.new(value)
        puts err
        if err.nil?
            user_id
        else
            value
        end
    end
end