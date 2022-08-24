class User < ApplicationRecord
  # has_many :user_rooms, dependent: :destroy
  # has_many :rooms, through: :user_rooms
  # has_many :words
  # has_many :users, through: :room_requests
  has_secure_password validations: true
  mount_uploader :avatar, AvatarUploader

  # before_create :create_remember_token

  # scope :email_select, EmailChakiQuery

  # def self.new_remember_token # selfを付けるとクラスメソッドになり「クラス名.メソッド」で呼び出せる
  #   SecureRandom.urlsafe_base64 # SecureRavdomはランダムな文字列生成
  # end

  # def self.encrypt(token)
  #   Digest::SHA256.hexdigest(token.to_s)
  # end

  # validates :name, presence: true, uniqueness: true


  # private

  # def create_remember_token
  #   self.remember_token = User.encrypt(User.new_remember_token)
  # end
end
