Dir['./domain/value_object/room/*.rb'].sort.each { |file| require file }


class RoomAggregate

    def name(value)
        name,err = RoomName.new(value)
        if err.nil?
            name
        else
            value
        end
    end

    def room_request(value)
        room_request,err = RoomRequestFlg.new(value)
        puts err
        if err.nil?
            room_request
        else
            value
        end
    end

    def admin_user(value)

        room_admin,err = RoomAdminUser.new(value)
        puts err
        if err.nil?
            room_admin
        else
            value
        end
    end
end