class EmailChakiQuery < Query
  DEFAULT_EMAIL = "sample"

  def initialize(relation = User.all)
    puts "初期化"
    @relation = relation
  end

  def call(name = DEFAULT_EMAIL)
    puts "callメソッド"
    relation.where("name like ?", "#{name}%")
  end
end
