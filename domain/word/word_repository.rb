

class WordRepository

    def initialize(db)
        @db = db
    end

    def insert(word)
        @db[:words].insert(
            word_id: word.word_id.value,
            term: word.term.value,
            conversion: word.conversion.value,
            user_id: word.user_id.value,
            created_at: Sequel::CURRENT_TIMESTAMP,
            updated_at: Sequel::CURRENT_TIMESTAMP
        )
    end


    def update(word)
        @db[:words].where(word_id: word.word_id.value, deleted_at: nil).update(
            term: word.term.value,
            conversion: word.conversion.value,
            user_id: word.user_id.value,
            updated_at: Sequel::CURRENT_TIMESTAMP
        )
    end

    def delete(word_id)
        @db[:words].where(word_id: word_id,deleted_at: nil).delete(
            deleted_at: Sequel::CURRENT_TIMESTAMP
        )
    end
end