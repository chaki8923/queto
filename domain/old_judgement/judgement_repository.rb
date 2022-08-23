

class JudgementRepository

    def initialize(db)
        @db = db
    end

    def insert(old_judgement)
        @db[:old_judgements].insert(
            judgement_id: old_judgement.judgement_id.value,
            title: old_judgement.title.value,
            image: old_judgement.image.value,
            created_at: Sequel::CURRENT_TIMESTAMP,
            updated_at: Sequel::CURRENT_TIMESTAMP,
        )
    end


    def update(old_judgement)
        @db[:old_judgement].where(judgement_id: old_judgement.judgement_id.value).update(
            title: old_judgement.title.value,
            image: old_judgement.image.value,
            updated_at: Sequel::CURRENT_TIMESTAMP,
        )
    end

    def delete(old_judgement)
        @db[:old_judgement].where(judgement_id: old_judgement.judgement_id.value).delete(
            deleted_at: Sequel::CURRENT_TIMESTAMP
        )
    end


end