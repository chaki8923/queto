class SessionController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]
  skip_before_action :adult_flg!, only: [:new, :create,:destroy]
  before_action :set_user, only: [:create]

  def new
  end

  def create

    @user = User.authenticate(name: session_params[:password])
    if @user.present?
      login(@user)
      redirect_to home_path
    else
      flash.now[:danger] = t('.flash.invalid_password')
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to login_path
  end

  private

  def set_user
    @user = User.find_by!(name: session_params[:name])
  rescue StandardError
    flash.now[:danger] = t('.flash.invalid_mail')
    render action: 'new'
  end

  def session_params
    params.require(:session).permit(:name,:avatar,:password, :password_confirmation)
  end
end
