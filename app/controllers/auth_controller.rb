class AuthController < ApplicationController
  skip_before_action :require_sign_in!, only: %i[new create top]
  skip_before_action :adult_flg!,
                     only: %i[new create avatar get_user update_avatar top]

  def new
    render("auth/home") if @current_user.present?
    @user = User.new
  end

  def index
    search_email = "wa"
    @users = User.email_select(search_email) # sqlは書かずに検索したいemailアドレスの文字を渡すだけ

    render("auth/home")
  end

  def top
    render("layouts/home")
  end

  def avatar
    puts "avatar!!!!"
    @user = @current_user
    render("auth/avatar")
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
      redirect_to "/auth/#{@user.id}/avatar"
    else
      render "new", status: :unprocessable_entity # これないとバリデーション出ない
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to home_path, notice: "編集されました"
    else
      render "edit", status: :unprocessable_entity # これないとバリデーション出ない
    end
  end

  def get_user
    puts "getuser"
    @user = @current_user
    render json: { id: @user.id }, status: 200
  end

  def update_avatar
    puts "update---------!!!"
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: { id: @user.id, avatar: @user.avatar }, status: 200
    else
      render json: {
               message: "失敗しました",
               error: @user.errors.messages
             },
             status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :remember_token,
      :avatar,
      :adult_flg,
      :password,
      :password_confirmation
    )
  end
end
