require 'uri'
require 'securerandom'
Dir['./domain/value_object/*.rb'].sort.each { |file| require file }


class User 
    attr_reader :user_id,:user_name,:password,:adult_flg,:avatar

    def initialize(user_id,user_name,password,adult_flg,avatar)
        @user_id = user_id
        @user_name = user_name
        @password = password
        @adult_flg = adult_flg
        @avatar = avatar
    end

    def self.new(user_id,user_name,password,adult_flg,avatar)

        user_id,err = UuId.new(user_id)
        return nil,err unless err.nil?

        user_name,err = Uname.new(user_name)
        return nil,err unless err.nil?
        
        password,err = Upassword.new(password)
        return nil,err unless err.nil?

        adult_flg,err = UadultFlg.new(adult_flg)
        return nil,err unless err.nil?
        
        avatar,err = Uimage.new(avatar)
        return nil,err unless err.nil?

        super(user_id,user_name,password,adult_flg,avatar)

    end

    def self.create(user_name,password,adult_flg,avatar)
        new(SecureRandom.uuid,user_name,password,adult_flg,avatar)
    end


end