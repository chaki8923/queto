class UserDomainServise

    def initialize(user_repository)
        @ur = user_repository
    end

    def user_exits?(name)
        user = @ur.find_by_name(name)

        return false if user.nil?

        true
    end

    def user_valid?(user_id)
        user = @ur.find_by_user_id(user_id)

        return false if user.nil?

        true
    end
end