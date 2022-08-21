equire 'uri'
require 'securerandom'
Dir['./app/domain/value_object/*.rb'].sort.each { |file| require file }


class User 
    attr_reader: :user_id,:user_name,:password,:adult_flg,:avatar

    def initialize
        @user_id = user_id
        @user_name = user_name
        @password = password
        @adult_flg = adult_flg
        @avatar = avatar
    end

    
end