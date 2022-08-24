require 'uri'
require 'securerandom'
Dir['./domain/value_object/*.rb'].sort.each { |file| require file }


class Actor 
    attr_reader :id,:user_name,:password,:adult_flg,:avatar
    puts 'ユーーーーざーーーー！'
    def initialize(id,user_name,password,adult_flg,avatar)
        @id = id
        @user_name = user_name
        @password = password
        @adult_flg = adult_flg
        @avatar = avatar
    end

    def self.new(id,user_name,password,adult_flg,avatar)


        id,err = UuId.new(id)
        return nil,err unless err.nil?

        user_name,err = Uname.new(user_name)
        return nil,err unless err.nil?
        
        password,err = Upassword.new(password)
        return nil,err unless err.nil?

        adult_flg,err = UadultFlg.new(adult_flg)
        return nil,err unless err.nil?
        
        avatar,err = Uimage.new(avatar)
        return nil,err unless err.nil?

        super(id,user_name,password,adult_flg,avatar)

    end

    def self.create(id,user_name,password,adult_flg,avatar)
        new(SecureRandom.uuid,user_name,password,adult_flg,avatar)
    end


end