
require 'domain/word/word_repository'

class WordUsecase
    def initialize(word_repository)
        @wr = word_repository
    end

    def insert_word(word_id,term,conversion,user_id)
        word,err = Word.new(word_id,term,conversion,user_id)
        return nil,err unless err.nil?

        @wr.insert(word)

        [word,nil]
    end

    def update_word(word_id,term,conversion,user_id)
        word,err = Word.new(word_id,term,conversion,user_id)
        return nil,err unless err.nil?

        @wr.update(word)

        [word,nil]
    end

    def delete_word(word_id)
        @wr.delete(word_id)
    end


end