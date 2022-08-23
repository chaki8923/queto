require 'uri'
require 'securerandom'
Dir['./domain/value_object/*.rb'].sort.each { |file| require file }


class Room


    attr_reader :message_id,:room_id,:room_name,:admin_user,:request_flg

    def initialize(message_id,room_id,room_name,admin_user,request_flg)
        @room_id = room_id
        @room_name = room_name
        @admin_user = admin_user
        @request_flg = request_flg
    end

    def self.new(message_id,room_id,room_name,admin_user,request_flg)

        message_id,err = UuId.new(message_id)
        return nil,err unless err.nil?

        room_id,err = UuId.new(room_id)
        return nil,err unless err.nil?

        room_name,err = RoomName.new(room_name)
        return nil,err unless err.nil?
        
        admin_user,err = RoomAdminUser.new(admin_user)
        return nil,err unless err.nil?
        
        request_flg,err = RoomRequestFlg.new(request_flg)
        return nil,err unless err.nil?

        super(room_id,room_name,admin_user,request_flg)
    end

    def self.create(room_name,admin_user,request_flg)
        new(SecureRandom.uuid,room_name,admin_user,request_flg)
    end
end