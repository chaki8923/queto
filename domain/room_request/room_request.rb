require 'securerandom'
Dir['./domain/value_object/*.rb'].sort.each { |file| require file }

class RoomRequest

    attr_reader :request_id,:user_id,:room_id

    def initialize(request_id,user_id,room_id)
        @request_id = request_id
        @user_id = user_id
        @room_id = room_id
    end

    def self.new(request_id,user_id,room_id)
        request_id,err = UuId.new(request_id)
        return nil,err unless err.nil?

        user_id,err = UuId.new(user_id)
        return nil,err unless err.nil?

        room_id,err = UuId.new(room_id)
        return nil,err unless err.nil?

        super(request_id,user_id,room_id)
    end

    def self.create(request_id,user_id,room_id)
        new(SecureRandom.uuid,SecureRandom.uuid,SecureRandom.uuid)
    end

end