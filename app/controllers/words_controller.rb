require './domains/command_service/user_command_service.rb'
require './domains/domain_object/user_domain.rb'
require './domains/aggregate/user_aggregate.rb'
require './infras/write_repository/user_write_repository.rb'
require './infras/read_repository/user_read_repository.rb'

require './domains/command_service/room_command_service.rb'
require './domains/domain_object/room_domain.rb'
require './domains/aggregate/room_aggregate.rb'
require './infras/write_repository/room_write_repository.rb'
require './infras/read_repository/room_read_repository.rb'

require './domains/command_service/message_command_service.rb'
require './domains/domain_object/message_domain.rb'
require './domains/aggregate/message_aggregate.rb'
require './infras/read_repository/message_read_repository.rb'
require './infras/write_repository/message_write_repository.rb'



class WordsController < ApplicationController
  
  before_action :dependency_injection,:dependency_injection_room,:dependency_injection_message

  
  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)
    if @word.save
      redirect_to words_index_path, notice: '用語が登録されました'
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def index
    @words = Word.all.page(params[:page]).per(5)
  end

  def edit
    @word = Word.find(params[:id])
  end

  def update
    @word = Word.find(params[:id])
    if @word.update(word_params)
      redirect_to words_index_path, notice: '編集されました'
    else
      render 'edit', status: :unprocessable_entity # これないとバリデーション出ない
    end
  end

  private

  def word_params
    params.require(:word).permit(:term, :conversion, :user_id)
  end

  
end
