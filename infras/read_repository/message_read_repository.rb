

class MessageReadRepository


    def find(id)
        
    end

    def get_all(room)
        room.messages.all.order(created_at: 'ASC')
    end

  

end