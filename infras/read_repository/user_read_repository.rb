
require './domains/read_repositable/user_read_repositable.rb'

class UserReadRepoistory < UserReadRepositable

    def find(id)
        User.find_by(id: id)
    end

    def get
    end
end