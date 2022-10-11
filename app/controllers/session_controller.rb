class SessionController < ApplicationController
  skip_before_action :require_sign_in!, only: %i[new create]
  skip_before_action :adult_flg!, only: %i[new create destroy]
  before_action :set_user, only: [:create]

  def new
    render("auth/home") if @current_user.present?
    @user = User.new
  end

  def create
    if @user.authenticate(session_params[:password])
      login(@user)
      redirect_to home_path
    else
      @params = session_params
      flash.now[:danger] = t("errors.messages.login")
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to home_path
  end

  private

  def set_user
    @user = User.find_by!(name: session_params[:name])
  rescue StandardError
    @params = session_params
    flash.now[:danger] = t("errors.messages.login")
    render action: "new"
  end

  def session_params
    params.require(:session).permit(
      :name,
      :avatar,
      :password,
      :password_confirmation
    )
  end
end
