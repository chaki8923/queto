class AuthController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]

  def new
    @user = User.new
  end

  def index
    search_email = 'cha'

    @users = User.email_select(search_email)
   
    render("auth/home")

  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to home_path
    else
      render 'new',status: :unprocessable_entity#これないとバリデーション出ない
    end
  
  end
  private
    def user_params
      params.require(:user).permit(:name,:email,:password, :password_confirmation,:remember_token)
    end
end
