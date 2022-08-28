# CommandService内のロジックや、CommandServiceからコールされているAcitveRecordのメソッドを分析し、更新しているActiveRecordのカラムを見つける
# 更新データの集約係

require './domains/value_object/user/name.rb'
require './domains/value_object/user/password.rb'
require './domains/value_object/user/adult_flg.rb'
require './domains/value_object/user/avatar.rb'


class UserAggregate

    def name(value)
        Name.new(value)
    end

    def password(value)
        Password.new(value)
    end

    def adult_flg(value)
        AdultFlg.new(value)
    end

    def avatar(value)
        Avatar.new(value)
    end


end