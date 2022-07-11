class User < ApplicationRecord
  has_secure_password validations: true
  before_create :create_remember_token
  

  scope :email_select, EmailChakiQuery
  
  def self.new_remember_token#selfを付けるとクラスメソッドになり「クラス名.メソッド」で呼び出せる
    SecureRandom.urlsafe_base64 #SecureRavdomはランダムな文字列生成
  end
  
  def self.encrypt(token)
    Digest::SHA256.hexdigest(token.to_s)
  end
  
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 4},allow_nil: true 
  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
