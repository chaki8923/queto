require 'bcrypt'

require './domain/user/user'
require './usecase/auth/auth_query_servise'

class AuthUseCase
    def initialize(user_repository,user_domain_servise,auth_query_servise)
        @ur = user_repository
        @uds = user_domain_servise
        @aqs = auth_query_servise
    end

    def sign_up(name,password)
        return nil,'user already exits' if @aqs.auth_user(name,password)
        password_hash = BCrypt::Password.create(password)
        user,err = User.new(name,password_hash)
        return nil,err unless err.nil?

        @ur.insert(user)

        [user,nil]
        
    end

    def sign_in(name,password)

        user,err = @aqs.auth_user(naem,password)
        return nil,'Invalid password or name' if user.nil?

        [user,nil]
    end
end