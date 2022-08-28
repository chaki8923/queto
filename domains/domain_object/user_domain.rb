# 見つけた演算処理を各々DomainObjectへ委譲する( つまりCommandServiceやActiveRecordから委譲する )。
# 今は更新でもfindでもないやつを記述
require './domains/value_object/user/name.rb'
require './domains/value_object/user/password.rb'



class UserDomain
    
    def create_instance(err,args,params)
        if err.nil?
            {name: args[:name].value,password: args[:password].value,password_confirmation: args[:password_confirmation]}
        else
            {name: params[:name],password: params[:password]}
        end
    end
    
end