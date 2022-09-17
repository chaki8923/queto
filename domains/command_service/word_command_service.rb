
require './domains/domain_object/word_domain.rb'
require './domains/aggregate/word_aggregate.rb'
require './infras/write_repository/word_write_repository.rb'
require './infras/read_repository/word_read_repository.rb'

class WordCommandService

    def initialize(word_domain,word_aggregate,word_write_repository,word_read_repository)
        @wd = word_domain
        @wa = word_aggregate
        @wwr = word_write_repository
        @wrr= word_read_repository
    end

    def create_instance

    end

    def create

    end

    def get_all
        @wrr.get_all
    end
end