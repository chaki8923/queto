# 見つけた演算処理を各々DomainObjectへ委譲する( つまりCommandServiceやActiveRecordから委譲する )。
require './domains/value_object/user/name.rb'
require './domains/value_object/user/password.rb'



class UserDomain
    クッキー使うとこから！！
    def user_create(params)

        user_name,err = Name.new(params[:name])
        user_password,err = Password.new(params[:password])

        if err.nil?
            User.new(name: user_name.value,password: user_password.value,password_confirmation: params[:password_confirmation])
        else
            User.new(name: name ,password: password)
        end
        
        
    end

    def login(params)
        user_name,err = Name.new(params[:name])
        user_password,err = Password.new(params[:password])


    end
    
    def token_update(user)
        remember_token = User.new_remember_token                  # remember_token作成
        cookies.permanent[:user_remember_token] = remember_token  # クッキーに入れて
        cookies.encrypted[:user_id] = user.id
        user.update!(remember_token: User.encrypt(remember_token)) # userテーブルのremember/tokenを更新
    end

    def user_update(params)

        @user = User.find(params[:id])
    end

end