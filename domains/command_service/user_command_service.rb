# ビジネス演算や判断がカプセル化されたDomainObjectをAggregateに格納し、AggregateをRepositoryの書き込みメソッドへ渡す仕組み
# 数値演算ロジックや業務判断の条件分岐がServiceに書かれたら負け
# 実行クラス。domainobjectのロジックを呼び出すだけ

require './domains/domain_object/user_domain.rb'
require './domains/aggregate/user_aggregate.rb'
require './domains/write_repositable/user_write_repositable.rb'


class UserCommandService
    def initialize(user_domain,user_aggregate,user_write_repository)
        @ud = user_domain
        @ua = user_aggregate
        @uwr = user_write_repository
    end

    def new(params)
        user_name,err = @ua.name(params[:name])
        user_password,err = @ua.password(params[:password])
        args = {name: user_name,password: user_password,password_confirmation: params[:password_confirmation]}
        user = @ud.create_instance(err,args,params)
        User.new(user)
    end
 
    def user_create(user)
        @uwr.save(user)
    end

    def token_update(user,cookies)
        @uwr.token_update(user,cookies)
    end

    def update(user)
        @uwr.update
    end
end