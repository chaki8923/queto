
class JudgementQueryServise
    def initialize(db)
        @db = db
    end

   
    def find_by_random(rand_num)
        @db[:old_judgements].where(judgement_id: rand_num, deleted_at: nil)
    end
    
   
    def count
        @db[:old_judgements].where(deleted_at: nil).count
    end
end