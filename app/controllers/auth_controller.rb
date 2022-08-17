class AuthController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]
  skip_before_action :adult_flg!, only: [:new, :create]

  def new
    @user = User.new
  end

  def index
    search_email = 'wa'
    @users = User.email_select(search_email) # sqlは書かずに検索したいemailアドレスの文字を渡すだけ

    render('auth/home')
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
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
    if @user.update(user_params)
      redirect_to home_path, notice: '編集されました'
    else
      render 'edit', status: :unprocessable_entity # これないとバリデーション出ない
    end
  end

  def get_user
    @user = @current_user
    render json: { id: @user.id }, status: 200
  end

  def update_avatar
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: { id: @user.id, avatar: @user.avatar }, status: 200
    else
      render json: { message: '失敗しました', error: @user.errors.messages }, status: 400
    end
  end
  
  def upload
    filename = params[:filename]
    puts 'S3----------------'

    presigned_object = S3_BUCKET.presigned_post(
      key: "uploads/test/#{@current_user.id}/#{filename}",
      success_action_status: '201',
      acl: 'public-read'
  )
  render json: { url: presigned_object.url, fields: presigned_object.fields }
  end

  
  private

    def user_params
      params.require(:user).permit(:name,  :remember_token, :avatar, :adult_flg)
    end


end
