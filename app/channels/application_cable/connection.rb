module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      puts 'コネクトーーーー'
      self.current_user = find_verified_user
      puts 'ID'
      puts current_user.id
    end


    private
    def find_verified_user
      puts '入った'
      if verified_user = User.find_by(id: cookies[:user_id])
        puts '入った２'
        verified_user
      else
        reject_unauthorized_connection
      end
    end

  end
end
