require 'bcrypt'

require './domain/user/user'
require './usecase/auth/auth_query_servise'

class AuthUseCase
    def initialize(user_repository,user_domain_service,auth_query_service)
        @ur = user_repository
        @uds = user_domain_service
        @aqs = auth_query_service
    end

    def sign_up(name,password)
        return nil,'user already exits' if @aqs.auth_user(name,password)
        password_hash = BCrypt::Password.create(password)
        user,err = User.new(id,name,password_hash,avatar)
        return nil,err unless err.nil?

        @ur.insert(user)

        [user,nil]
        
    end

    def sign_in(name,password)

        user,err = @aqs.auth_user(name,password)
        return nil,'Invalid password or name' if user.nil?

        [user,nil]
    end
end