class SessionController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]
  skip_before_action :adult_flg!, only: [:new, :create,:destroy]
  before_action :set_user,:dependency_injection, only: [:create]
  require './domains/command_service/user_command_service.rb'
  require './domains/domain_object/user_domain.rb'

  def new
    if @current_user.present?
      render('auth/home')
    end
    @user = User.new
  end

  def create
    
    if @user.authenticate(session_params[:password])
      @ucs.token_update(@user,cookies)
      redirect_to home_path
    else
      @params = session_params
      flash.now[:danger] = t('errors.messages.login')
      render 'new',status: :unprocessable_entity
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
    flash.now[:danger] = t('errors.messages.login')
    render action: 'new'
  end

  def session_params
    params.require(:session).permit(:name,:avatar,:password, :password_confirmation)
  end


  def dependency_injection
    ud = UserDomain.new
    ua = UserAggregate.new
    uwr = UserWriteRepository.new
    @ucs = UserCommandService.new(ud,ua,uwr)

  end

end
