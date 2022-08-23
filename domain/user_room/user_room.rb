require 'uri'
require 'securerandom'
Dir['./domain/value_object/*.rb'].sort.each { |file| require file }

class UserRoom

    attr_reader :user_room_id,:user_id,:room_id

    def initialize(user_room_id,user_id,room_id)
        @user_room_id = user_room_id
        @user_id = user_id
        @room_id = room_id
    end

    def self.new(user_room_id,user_id,room_id)

        user_room_id,err = UuId.new(user_room_id)
        return nil.err unless err.nil?

        user_id,err = UuId.new(user_id)
        return nil,err unless err.nil?

        room_id,err = UuId.new(room_id)
        return nil,err unless err.nil?

        super(user_room_id,room_id,user_id)
    end

    def self.create(user_room_id,room_id,user_id)

        new(SecureRandom.uuid,SecureRandom.uuid,SecureRandom.uuid)
    end
end