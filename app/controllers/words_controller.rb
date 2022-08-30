class WordsController < ApplicationController
  

  
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
    @words = Word.all
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
