class AuthController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    puts user_params;
    puts @user
    if @user.save
      redirect_to('/home')
    else
      render 'new',status: :unprocessable_entity#これないとバリデーション出ない
    end
  
  end
  

  private
  def user_params
    params.require(:user).permit(:name,:email,:password, :password_confirmation)
  end
end
