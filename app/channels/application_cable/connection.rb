module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      puts 'コネクト'
      self.current_user = find_verified_user
      puts current_user.name
    end

    private

    def find_verified_user

      if current_user = User.find_by(id: cookies.encrypted[:user_id]) # sessionにアクセスできない
        current_user
      else
      reject_unauthorized_connection
      end
    end
  end
end
