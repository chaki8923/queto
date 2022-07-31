module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = User.find_by(id: cookies[:user_id])
      puts 'ユーザーーーーー'
      puts current_user.id
    end

    def disconnect
      # Any cleanup work needed when the cable connection is cut.
    end

  end
end
