require 'sequel'

class UserRepository

    def initialize(db)
        @db = db
    end

    def insert(user)
        @db[:users].insert(
            user_id: user.user_id.value,
            name: user.user_name.value,
            password: user.password.value,
            avatar: user.avatar.value,
            created_at: Sequel::CURRENT_TIMESTAMP,
            updated_at: Sequel::CURRENT_TIMESTAMP

        )
    end

    def find_by_name(name)
        @db[:users].where(name: name,deleted_at: nil).first
    end

    def find_by_user_id(user_id)
        @db[:user].where(id: user_id,deleted_at: nil).first
    end

    def update(user)
        @db[:users].where(id: user.user_id.value,deleted_at: nil).update(
            name: user.user_name.value,
            password: user.password.value,
            avatar: user.avatar.value,
            updated_at: Sequel::CURRENT_TIMESTAMP
        )
    end

    def delete(user)
        @db[:users].where(id: user.user_id.value).delete(
            deleted_at: Sequel::CURRENT_TIMESTAMP
        )
    end
end