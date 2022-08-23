require './domain/user/user'
require 'bcrypt'

class UserUseCase
    def initialize(user_repository,user_domain_servise)
        @ur = user_repository
        @uds = user_domain_servise
    end

    def get_user(user_id)
        @uqs.find_user(user_id)
    end

   

    def put_user(user_id,user_name,password,adult_flg,avatar)
        return nil,'user is not found' unless @uds.user_valid?(user_id)

        password_hash = BCrypt::Password.create(password)
        user,err = User.new(user_id,user_name,password_hash,adult_flg,avatar)
        return nil,err unless err.nil?

        @ur.update(user)

        [user.nil]
    end

    def get_rooms(user_id)
        @uqs.find_user_with_rooms(user_id)
    end

    def delete_user(user_id)
        return nil,'user is not found' unless @uds.user_valid?(user_id)

        [@ur.delete(user_id),nil]
    end
  
end