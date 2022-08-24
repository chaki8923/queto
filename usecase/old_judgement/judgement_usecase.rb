require './domain/old_judgement/judgement_repository'
require './domain/old_judgement/judgement_query_servise'



class JudgementUsecase
    def initialize(judgement_repository,judgement_query_service)
        @jr = judgement_repository
        @jqr = judgement_query_service
    end

    def insert(judgement_id,title,image)
        judgement,err = OldJudgement.new(judgement_id,title,image)
        return nil,err unless err.nil?

        @jr.insert(judgement)

        [judgement,nil]
    end
    
    def update(judgement_id,title,image)
        return nil,err unless err.nil?
    
        @jr.update(judgement)
    
        [judgement,nil]
    end

    def delete(judgement_id)
        @jr.delete(judgement_id)
    end

    def get_random(rand_num)
        @jqr.find_by_random(rand_num)
    end
    
    def get_count
        @jqr.count
    end
end
