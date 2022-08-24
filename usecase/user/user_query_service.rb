# CQRSの概念
# コマンド（DBのデータを登録、更新、削除）、クエリ（DBのデータの取得）を分ける。
# require 'sequel'



class UserQueryService
    def initialize(db)
        @db = db
    end

    def find_user(user_id)
        @db[:users].where(id: user_id).first
    end

    def find_user_with_rooms(user_id)
        @db[:users].join_table(:left,@db[:user_rooms],id: user_id).where(Sequel[:users][:id] => user_id).all
    end

end