class User < ApplicationRecord
  
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms,dependent: :destroy
  has_many :words,dependent: :destroy
  has_many :users, through: :room_requests,dependent: :destroy
  mount_uploader :avatar, AvatarUploader
  
  
  scope :email_select, EmailChakiQuery
  
  def self.new_remember_token # selfを付けるとクラスメソッドになり「クラス名.メソッド」で呼び出せる
    SecureRandom.urlsafe_base64 # SecureRavdomはランダムな文字列生成
  end
  
  def self.encrypt(token)
    Digest::SHA256.hexdigest(token.to_s)
  end
  
  validates :name, presence: true
  validates :name, uniqueness: true,on: :create
  has_secure_password validations: true
  validates :password, length: { minimum: 5 }, if: :update_password?
  

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end

  def update_password?
    password.to_s != ''
end
end
