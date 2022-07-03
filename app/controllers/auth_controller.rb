class AuthController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    puts user_params;
    puts @user
    if @user.save
      redirect_to action: :home
    else
      render 'new',status: :unprocessable_entity
    end
    

  end

  def home
    render('home')
  end
  

  private
  def user_params
    params.require(:user).permit(:name,:email,:password, :password_confirmation)
  end
end
