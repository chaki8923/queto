class Query
    class << self
        delegate :call, to: :new
    end

    def call
        puts 'コーーーーーる'
        raise NotImplementedError
    end

    private
    
    attr_reader :relation
end
