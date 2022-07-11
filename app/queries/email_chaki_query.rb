class EmailChakiQuery < Query
    

    DEFAULT_EMAIL = 'sample'

    def initialize(relation = User.all)
        puts '初期化'
        @relation = relation
    end

    def call(email = DEFAULT_EMAIL)
        puts 'callメソッド'
        relation.where('email like ?',"#{email}%")
    end

end