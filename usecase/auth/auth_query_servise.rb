require 'bcrypt'

class AuthQueryServise

    def initialize(db)
        @db = db
    end

    def auth_user(name,password)

        user = @db[:users].where(name: name).first

        user if user.password ==  BCrypt::Engine.hash_secret(password, user.password)
    end
end