class ApplicationController < ActionController::Base
  before_action :current_user
  before_action :set_user_id_to_cookie
  before_action :require_sign_in!
  helper_method :signed_in?

  protect_from_forgery with: :exception # csrf対策

  def current_user
    remember_token = User.encrypt(cookies[:user_remember_token]) # クッキーのremember_tokenハッシュ化
    @current_user ||= User.find_by(remember_token: remember_token) # テーブルに存在すればremember_token代入。存在しなければfalse
  end

  def login(user)
    remember_token = User.new_remember_token                  # remember_token作成
    cookies.permanent[:user_remember_token] = remember_token  # クッキーに入れて
    cookies.encrypted[:user_id] = user.id
    user.update!(remember_token: User.encrypt(remember_token)) # userテーブルのremember/tokenを更新
  end

  def logout
    cookies.delete(:user_remember_token)
  end

  def signed_in?
    @current_user.present?
  end

  private

  def require_sign_in!
    redirect_to login_path unless signed_in?
  end

  # ActionCable用
  # login時にセットするようにはしているが、それだけだとすでにログインしているユーザーに対してクッキーをセットできないので暫定的にこうする
  def set_user_id_to_cookie
    cookies.permanent[:user_id] = @current_user.id if @current_user
  end
end
