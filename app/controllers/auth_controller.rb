require './domains/command_service/user_command_service.rb'
require './domains/domain_object/user_domain.rb'
require './domains/aggregate/user_aggregate.rb'
require './infras/write_repository/user_write_repository.rb'

class AuthController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create,:top]
  skip_before_action :adult_flg!, only: [:new, :create,:avatar,:get_user,:update_avatar,:top]

  before_action :dependency_injection


  def new
    @user = User.new
  end

  def index

    render('auth/home')
  end
  
  def top
    render('layouts/home')
  end
  
  def avatar
    puts 'avatar!!!!'
    @user = @current_user
    render('auth/avatar')
  end

  def create
    @user = @ucs.new(user_params)
    if  @ucs.user_create(@user)
      @ucs.token_update(@user,cookies)
      redirect_to "/auth/#{@user.id}/avatar"
    else
      render 'new', status: :unprocessable_entity # これないとバリデーション出ない
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    
    @user = User.find(params[:id])
    if @ucs.update(@user)
      redirect_to home_path, notice: '編集されました'
    else
      render 'edit', status: :unprocessable_entity # これないとバリデーション出ない
    end
  end

  # api
  def get_user
    @user = @current_user
    render json: { id: @user.id }, status: 200
  end

  def update_avatar
    puts 'update---------!!!'
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: { id: @user.id, avatar: @user.avatar }, status: 200
    else
      render json: { message: '失敗しました', error: @user.errors.messages }, status: 400
    end
  end
  
  
  private

    def user_params
      params.require(:user).permit(:name,  :remember_token, :avatar, :adult_flg,:password, :password_confirmation)
    end

    def dependency_injection
      ud = UserDomain.new
      ua = UserAggregate.new
      uwr = UserWriteRepository.new
      @ucs = UserCommandService.new(ud,ua,uwr)

    end


end
