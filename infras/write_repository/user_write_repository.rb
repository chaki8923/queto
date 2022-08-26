
require './domains/domain_object/user_domain.rb'
require './domains/write_repositable/user_write_repositable.rb'

class UserWriteRepository

    def save(user)
        user.save
    end

    def update(user)
        user.update
    end

    def token_update(user,cookies)
        remember_token = User.new_remember_token                  # remember_token作成
        cookies.permanent[:user_remember_token] = remember_token  # クッキーに入れて
        cookies.encrypted[:user_id] = user.id
        user.update!(remember_token: User.encrypt(remember_token)) # userテーブルのremember/tokenを更新
    end

end