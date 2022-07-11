class AuthController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]

  def new
    @user = User.new
  end

  def index
    puts 'インデックス！！'
    @users = User.email_select('chaki')
   
    render("auth/home")

  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to('/app/auth/home')
    else
      render 'new',status: :unprocessable_entity#これないとバリデーション出ない
    end
  
  end
  private
    def user_params
      params.require(:user).permit(:name,:email,:password, :password_confirmation,:remember_token)
    end
end
