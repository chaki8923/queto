class OldJudgementsController < ApplicationController
    def index

    end
    
    def get_judgement
            puts params


            if params['id2'].to_i == 2 
                
                if params['oji_answer'].to_i >= 2
                    puts 'あなたはおじさんでーーーーす！'
                    @user = User.find_by(id: @current_user.id)
                    @user.update!(adult_flg: true)
                end
            else

                if params['id'].present? && params['id2'].present?
                    @question = OldJudgement.where.not(id: params['id']).where.not(id: params['id2']).first
                elsif params['id'].present? 
                    @question = OldJudgement.where.not(id: params['id']).first
                else
                    @question = OldJudgement.offset(rand(OldJudgement.count)).first
                end
            end
   
       
        if @question.present?
            render json: { data: @question }, status: 200
        else
            render json: { message: 'エラーです' }, status: 400
        end
    end
end
