class SessionController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]
  before_action :set_user, only: [:create]

  def new
  end

  def create

    @user = User.find_by!(name: session_params[:name])
    if @user.present?
      login(@user)
      redirect_to words_new_path
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
    params.require(:session).permit(:name)
  end
end
