class WordsController < ApplicationController


  def new
    @word = Word.new
  end

  def create
    puts '上ーーーーーーーーーーーーーーーー'
    @word = Word.new(word_params)
    puts '下ーーーーーーーーーーーーーーーー'
    if @word.save
      render 'new'
    else
      render 'new',status: :unprocessable_entity
    end
  end

  def index
  end

  private
  def word_params
    params.require(:word).permit(:term,:conversion)
  end

   
end
