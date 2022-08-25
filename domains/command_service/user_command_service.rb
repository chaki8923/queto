# ビジネス演算や判断がカプセル化されたDomainObjectをAggregateに格納し、AggregateをRepositoryの書き込みメソッドへ渡す仕組み
# 数値演算ロジックや業務判断の条件分岐がServiceに書かれたら負け
# 実行クラス

require './domains/domain_object/user_domain.rb'


class UserCommandService
    def initialize(user_domain)
        @ud = user_domain
    end
 
    def user_create(params)
        @ud.user_create(params)
    end

    def token_update(user)
        @ud.token_uodate(user)
    end

    def update
    end
end