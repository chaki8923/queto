

class RoomQueryService
    def initialize(db)
        @db = db
    end

    # クエリ
    def find_by_all
        @db[:rooms].where(deleted_at: nil).order(:created_at)
    end
end