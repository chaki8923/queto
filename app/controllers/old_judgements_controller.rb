class OldJudgementsController < ApplicationController
    def index
        if @current_user.adult_flg.nil?
            # adult_flg がnilなら表示
        else
            # redirect_to home_path
        end
    end
    
    def get_judgement
            puts params
            puts 'おじ回答回数'
            puts params['oji_answer']
  
            
            if params['id'].present? && params['id2'].present?
                @question = OldJudgement.where.not(id: params['id']).where.not(id: params['id2']).first
            elsif params['id'].present? 
                @question = OldJudgement.where.not(id: params['id']).first
            else
                @question = OldJudgement.offset(rand(OldJudgement.count)).first
            end
            
            
            if @question.present?
                render json: { data: @question }, status: 200
            else
                render json: { message: 'エラーです' }, status: 400
            end
        end

        def create_judgement
            puts 'ojiparams'
            puts params
            if params['oji'].to_i == 1
                puts 'あなたはおじさんでーーーーす！'
                @user = User.find_by(id: @current_user.id)
                @user.update!(adult_flg: true)
            else
                @user = User.find_by(id: @current_user.id)
                @user.update!(adult_flg: false)
            end
        end
end
