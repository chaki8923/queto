# CQRSの概念
# コマンド（DBのデータを登録、更新、削除）、クエリ（DBのデータの取得）を分ける。
require 'sequel'



class UserQueryServise
    def initialize(db)
        @db = db
    end

    def find_user(user_id)
        @db[:users].where(user_id: user_id).first
    end

    def find_user_with_rooms(user_id)
        @db[:uses].join_table(:left,@db[:user_rooms],user_id: user_id).where(Sequel[:users][:user_id] => user_id).all
    end

end